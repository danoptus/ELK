#!/bin/bash

echo "
++++++++++++++++++++++++++++++++++++++++ 
   
        By
            H0lmmes
       
+++++++++++++++++++++++++++++++++++++++++
"

echo "Informe o cluste.name: "
read cluster
echo "Informe o node.name: "
read node
echo "Informe o ip do master: "
read master


ES_VERSION="7.5.1-linux-x86_64"
ESSTACK_DIR="/elasticstack"
ES_APPS="elasticsearch/elasticsearch kibana/kibana logstash/logstash beats/metricbeat/metricbeat beats/filebeat/filebeat beats/packetbeat/packetbeat beats/auditbeat/auditbeat apm-server/apm-server"
# Desabilitando o IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Criando diretório de instalacao
mkdir -p $ESSTACK_DIR/datasets

#Instalando as ferramentas do SO
yum install -y tzdata net-tools curl git

# Baixando as ferramentas da Stack
for APPS in $ES_APPS; do
   if [ "$APPS" == "logstash/logstash" ]; then
      wget -P $ESSTACK_DIR https://artifacts.elastic.co/downloads/$APPS.tar.gz
   else
      wget -P $ESSTACK_DIR https://artifacts.elastic.co/downloads/$APPS-$ES_VERSION.tar.gz
   fi
done

#Criação de usuário
useradd -d /opt/elastic -m elastic

#Config limits.conf
echo "elastic – nofile 65536 " >> /etc/security/limits.conf  

#Configura o mapeamento de memória pela heap
echo "vm.max_map_count = 262144" >> /etc/sysctl.conf  
sysctl -p  

#Desabilita o swap
sed -i '/swap/s/^\(.*\)$/#\1/g' /etc/fstab

#Habilita o serviço postfix
systemctl enable postfix && systemctl start postfix 

#Config das portas 9200 e 9300
firewall-cmd --permanent --add-port=9200/tcp && firewall-cmd --permanent --add-port=9300/tcp && firewall-cmd --reload  

#Move, descompacta e altera permissões dos arquivos baixados
clear
echo "
Movendo os arquivos para /opt/elastic
--------------------------------------
"
cp /elasticstack/*.gz /opt/elastic 

echo "
Descompactando os arquivos em /opt/elastic
------------------------------------------
"
cd /opt/elastic/ && for i in *; do tar -xf $i;done
chown elastic.elastic /opt/elastic/* -R  
rm -f *.gz 

echo "
Configurando o elasticsearch.yml
----------------------------------
"
sleep 2

#Configura o arquivo principal do elasticsearch
echo "
cluster.name: $cluster
node.name: $node
node.attr.zone: 1
node.attr.type: hot
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ['$master']
cluster.initial_master_nodes: ['$master']
path.data: /elasticstack/es/data
path.logs: /elasticstack/es/logs 
"  > /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml

#Cria os diretórios data e logs e altera as permissões
mkdir -p /elasticstack/es/logs && mkdir -p /elasticstack/es/data && chown elastic.elastic /elasticstack/es/* -R 

echo "

++++++++++++++++++++++++++

Configuração finalizada

++++++++++++++++++++++++++

"




                    

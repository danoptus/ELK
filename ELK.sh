#!/bin/bash

echo "
++++++++++++++++++++++++++++++++++++++++ 
   
        By
            H0lmmes
       
+++++++++++++++++++++++++++++++++++++++++
"

sleep 3

clear

echo "
Informe o seu username: "
read username

clear

echo "                            
                              
                              
 Iniciando a instalação e configuração do ElasticSearch
 ---------------------------------------------------------

"

sleep 3


ES_VERSION="7.5.1-linux-x86_64"
ESSTACK_DIR="/elasticstack"
ES_APPS="elasticsearch/elasticsearch kibana/kibana logstash/logstash beats/metricbeat/metricbeat beats/filebeat/filebeat beats/packetbeat/packetbeat beats/auditbeat/auditbeat apm-server/apm-server"
# Desabilitando o IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Criando diretório de instalacao
mkdir -p /opt/elastic
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
#useradd -d /opt/elastic -m elastic

#Config limits.conf
echo "
$username   nofile    65536
$username   hard    nofile    65536
$username   soft    nofile    65536
$username   hard    nofile    65536 
" >> /etc/security/limits.conf  

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
chown $username.$username -R /opt/elastic  
rm -f *.gz 


echo "
Configurando o elasticsearch.yml
----------------------------------
"
sleep 2

#Configura o arquivo principal do elasticsearch


echo "
Informe o cluste.name: "
read cluster
echo "
Informe o node.name: "
read node

echo "
Informe a quantidade de masters:
[1]
[2]
[3]
[4]
"
read quantidade_masters

case $quantidade_masters in 
      1)

echo " 
Informe o IP do Master:
"
read master

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

esac

case $quantidade_masters in 
    2)
     echo "
Informe o ip dos master 1: "
    read master1
      echo "
Informe o ip dos master 2: "
    read master2
    
 echo "
cluster.name: $cluster
node.name: $node
node.attr.zone: 1
node.attr.type: hot
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ['$master1','$master2']
cluster.initial_master_nodes: ['$master1','$master2']
path.data: /elasticstack/es/data
path.logs: /elasticstack/es/logs 
"  > /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
 esac


case $quantidade_masters in 
    3)
    echo "
Informe o ip dos master 1: "
    read master1
    echo "
Informe o ip dos master 2: "
    read master2
    echo "
Informe o ip dos master 3: "
    read master3
    
 echo "
cluster.name: $cluster
node.name: $node
node.attr.zone: 1
node.attr.type: hot
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ['$master1','$master2','$master3']
cluster.initial_master_nodes: ['$master1','$master2','$master3']
path.data: /elasticstack/es/data
path.logs: /elasticstack/es/logs 
"  > /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml

 esac
 
 
 case $quantidade_masters in 
    4)
   echo "
Informe o ip dos master 1: "
    read master1
    echo "
Informe o ip dos master 2: "
    read master2
    echo "
Informe o ip dos master 3: "
    read master3
   echo "
Informe o ip dos master 4: "
    read master4
    
echo "
cluster.name: $cluster
node.name: $node
node.attr.zone: 1
node.attr.type: hot
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ['$master1','$master2','$master3','$master4']
cluster.initial_master_nodes: ['$master1','$master2','$master3','$master4']
path.data: /elasticstack/es/data
path.logs: /elasticstack/es/logs 
"  > /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
    
 esac
 


#Cria os diretórios data e logs e altera as permissões
mkdir -p /elasticstack/es/logs && mkdir -p /elasticstack/es/data && chown $username.$username /elasticstack/es/* -R 


echo "

++++++++++++++++++++++++++

Configuração finalizada :)

++++++++++++++++++++++++++

"




                    

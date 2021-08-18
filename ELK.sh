#!/bin/bash
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


#Criação de usuário e configuração do elasticsearch
useradd -d /opt/elastic -m elastic
echo "elastic – nofile 65536 " >> /etc/security/limits.conf #Configura o limits
echo "vm.max_map_count = 262144" >> /etc/sysctl.conf  #Configura o mapeamento de memória pela heap do elasticsearch
sysctl -p 
sed -i '/swap/s/^\(.*\)$/#\1/g' /etc/fstab #Desabilita o swap
systemctl enable postfix && systemctl start postfix #Habilita o serviço postfix
firewall-cmd –permanent –add-port=9200/tcp && firewall-cmd –permanent –add-port=9300/tcp && firewall-cmd –reload #Confirua regras de firewall
cp *.gz /opt/elastic && tar -xf /opt/elastic/* && chown elastic.elastic /opt/elastic/* -R  



echo "
cluster.name: $cluster
node.name: $Node
node.attr.zone: 1
node.attr.type: host
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ['$master']
cluster.initial_master_nodes: ['$master']
path.data: /elasticstack/es/data
path.logs: /elasticstack/es/logs 
"  > /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml

mkdir -p /elasticstack/es/logs && mkdir -p /elasticstack/es/data && chown elastic.elastic /elasticstack/es/* -R




                    

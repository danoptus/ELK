#!/bin/bash
clear


echo "

++++++++++++++++++++++++++++++++++++++++++
 
 Iniciando o ajuste dos certificados
 
++++++++++++++++++++++++++++++++++++++++++
 "
 sleep 3
 
echo "
Informe a quantidade de masters no ambiente:
"
read masters

echo " 
Informe a quantidade de datas no ambiente: "
read datas
 
 
 #Gera CA auto assinada
 echo "
 ##################################
 Gerando certificado auto-assinado
 #################################
 "
 sleep 2
 mkdir -p /opt/elastic/elasticsearch-7.5.1/config/certs
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil ca --out /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --pass
 
 #Gerando certificado para os datas e masters
 
 if $masters > 1
 then
  for i in {1..$i}
  do  
  echo "
  Informe o ip dos hosts masters: "
  read ip
  /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/master-$i.p12 --pass
 
 else
 echo "
 Informe o ip do host master: "
 read ip
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/master-1.p12 --pass
 
 
 if $datas > 1
 then
  for i in {1..$i}
  do  
  echo "
  Informe o ip dos hosts datas: "
  read ip
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/data-$i.p12 --pass
 
 else
 echo "
 Informe o ip do host data: "
 read ip
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/data-1.p12 --pass
 
 
 
 

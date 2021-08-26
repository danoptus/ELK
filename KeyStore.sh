#!/bin/bash

clear
echo "
++++++++++++++++++++++++++++++++++++++++++++
     
 Iniciando  Ajuste KeyStore

++++++++++++++++++++++++++++++++++++++++++++

"
sleep 2
#ssl
/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password

#Trusts
/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password

#http
/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password

#http trusts
/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-keystore add xpack.security.http.ssl.truststore.secure_password

clear

#Ajuste no elasticsearch.yml

echo "
Escolha qual o server que tera o elasticsearch.yml ajustado:

 Data: 1
 Master: 2
"
read data_master

clear
case $data_master in 1)
host='data'
echo "
Escolha em qual data sera configurado o keystore:
Data-1:  1
Data-2:  2
Data-3:  3
Data-4:  4
"
read Data
esac

case $Data in 1)
echo "
#transport ssl
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/$host-1.p12
xpack.security.transport.ssl.truststore.path: certs/$host-1.p12

#HTTP
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/$host-1.p12
xpack.security.http.ssl.truststore.path: certs/$host-1.p12
" >> /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
esac

case $Data in 2)
echo "
#transport ssl
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/$host-2.p12
xpack.security.transport.ssl.truststore.path: certs/$host-2.p12

#HTTP
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/$host-2.p12
xpack.security.http.ssl.truststore.path: certs/$host-2.p12
">>/opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
esac


case $Data in 3)
echo "
#transport ssl
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/$host-3.p12
xpack.security.transport.ssl.truststore.path: certs/$host-3.p12

#HTTP 
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/$host-3.p12
xpack.security.http.ssl.truststore.path: certs/$host-3.p12
" >> /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
esac

case $Data in 4)
echo "
#transport ssl
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/$host-4.p12
xpack.security.transport.ssl.truststore.path: certs/$host-4.p12

#HTTP
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/$host-4.p12
xpack.security.http.ssl.truststore.path: certs/$host-4.p12
" >> /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
esac

case $data_master in 2)
host='master'
echo "
#transport ssl
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: certs/$host-1.p12
xpack.security.transport.ssl.truststore.path: certs/$host-1.p12

#HTTP
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: certs/$host-1.p12
xpack.security.http.ssl.truststore.path: certs/$host-1.p12
" >> /opt/elastic/elasticsearch-7.5.1/config/elasticsearch.yml
esac

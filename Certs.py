import os
os.system("clear")

print ("""

++++++++++++++++++++++++++++++++++++++++++
 
 Iniciando o ajuste dos certificados
 
++++++++++++++++++++++++++++++++++++++++++
 """)
 
os.system("sleep 3")
 
masters = input("\n Informe a quantidade de masters no ambiente: ")
datas = input( "\nInforme a quantidade de datas no ambiente: ")
 
 
 #Gera CA auto assinada
print ("""
 ##################################
 Gerando certificado auto-assinado
 #################################
 """)
os.system("sleep 2")
os.system("mkdir -p /opt/elastic/elasticsearch-7.5.1/config/certs
/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil ca --out /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --pass")
 
 
 #Gerando certificado para os datas e masters
 
if masters > 1:
    for i in range(masters):
     ip =  input("\nInforme o ip dos hosts masters: "
     os.system("/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip"+ip+" --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/master-"+i".p12 --pass")
     
  
else
 ip = input("\nInforme o ip do host master: ")
 os.system("/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip"+ip+" --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/master-1.p12 --pass")
 
 '''
 if $datas > 1
 then
  for i in {1..$i}
  do  
  echo "
  Informe o ip dos hosts datas: "
  read ip
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/data-$i.p12 --pass
  done
  
 else
 echo "
 Informe o ip do host data: "
 read ip
 /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip $ip --out /opt/elastic/elasticsearch-7.5.1/config/certs/certs/data-1.p12 --pass
 fi
 '''
 
 

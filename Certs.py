import os
os.system("clear")

print ("""

++++++++++++++++++++++++++++++++++++++++++
 
 Iniciando o ajuste dos certificados
 
++++++++++++++++++++++++++++++++++++++++++
 """)
 
os.system("sleep 3")
 
masters = int(input("\n Informe a quantidade de masters no ambiente: "))
datas = int(input( "\nInforme a quantidade de datas no ambiente: "))
 
 
 #Gera CA auto assinada
print ("""
 ##################################
 Gerando certificado auto-assinado
 #################################
 """)
os.system("sleep 2")
os.system("mkdir -p /opt/elastic/elasticsearch-7.5.1/config/certs && /opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil ca --out /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --pass")
 
 
 #Gerando certificado para os datas e masters
 os.system("clear")
 print("""
 #########################################
 Criando certificados para o server master
 #########################################
 """)
 
if masters > 1:
    for i in range(masters):
       i = i+1
      ip =  input("\nInforme o ip do master-{}: ".format(i))
      config_certs  = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {}  --out /opt/elastic/elasticsearch-7.5.1/config/certs/master-{}.p12 --pass".format(ip,i)
      os.system(config_certs)
     
  
else:
 ip = input("\nInforme o ip do host master: ")
 config_certs = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {} --out /opt/elastic/elasticsearch-7.5.1/config/certs/master-1.p12 --pass".format(ip)
 os.system(config_certs)
 
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
 
 

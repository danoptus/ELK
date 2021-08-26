import os
os.system("clear")

print ("""

++++++++++++++++++++++++++++++++++++++++++
 
 Iniciando o ajuste dos certificados
 
++++++++++++++++++++++++++++++++++++++++++
 """)
 
os.system("sleep 3")
 
masters = int(input("\nInforme a quantidade de masters no ambiente: "))
datas =   int(input("\nInforme a quantidade de datas no ambiente: "))
os.system("clear") 
 
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
      os.system("clear")
      config_certs  = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {}  --out /opt/elastic/elasticsearch-7.5.1/config/certs/master-{}.p12 --pass".format(ip,i)
      os.system(config_certs)
      os.system("clear")
     
  
else:
 ip = input("\nInforme o ip do master-1: ")
 config_certs = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {} --out /opt/elastic/elasticsearch-7.5.1/config/certs/master-1.p12 --pass".format(ip)
 os.system(config_certs)
 os.system("clear")
 
 
 
 
os.system("clear")
print("""
 #########################################
 Criando certificados para o server data
 #########################################
 """)
 
if datas > 1:
    for i in range(datas):
      i = i+1
      ip =  input("\nInforme o ip do master-{}: ".format(i))
      os.system("clear")
      config_certs  = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {}  --out /opt/elastic/elasticsearch-7.5.1/config/certs/data-{}.p12 --pass".format(ip,i)
      os.system(config_certs)
      os.system("clear")
     
  
else:
 ip = input("\nInforme o ip do master-1: ")
 config_certs = "/opt/elastic/elasticsearch-7.5.1/bin/elasticsearch-certutil cert --ca  /opt/elastic/elasticsearch-7.5.1/config/certs/ca.p12 --ca-pass --ip {} --out /opt/elastic/elasticsearch-7.5.1/config/certs/data-1.p12 --pass".format(ip)
 os.system(config_certs)
 os.system("clear")
 
 

 

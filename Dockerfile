FROM jboss/keycloak:16.0.0

#FROM yunoguthi/keycloak-tls:latest


#WORKDIR /opt/keycloak
 
# Exponha as portas HTTP (8080 por padrão) e HTTPS (8443 por padrão)
EXPOSE 8080
EXPOSE 8443
 
# Copie os arquivos de chave e certificado para o diretório apropriado no contêiner
COPY keycloak.crt /etc/x509/https/tls.crt
COPY keycloak.key /etc/x509/https/tls.key

ENV KEYCLOAK_USER=teste
ENV KEYCLOAK_PASSWORD=teste
ENV PROXY_ADDRESS_FORWARDING=true
ENV KEYCLOAK_ADMIN = admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Adicione um usuário admin
RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh -r master -u admin -p admin



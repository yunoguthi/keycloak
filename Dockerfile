# Use a imagem oficial do Keycloak 16
FROM jboss/keycloak:16.0.0

WORKDIR /opt/keycloak
 
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

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]



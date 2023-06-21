# Use a base image do Keycloak
FROM quay.io/keycloak/keycloak:latest as builder


# Copie o arquivo de configuração personalizado para a imagem
COPY standalone-ha.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml

# Copie o arquivo de configuração do proxy reverso para a imagem
COPY proxy.conf /opt/jboss/keycloak/proxy.conf

# Configure as variáveis de ambiente para a configuração do Keycloak
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV PROXY_ADDRESS_FORWARDING=true

# Expõe as portas para HTTP e HTTPS
EXPOSE 8080
EXPOSE 8443

# Executa o servidor Keycloak com HTTPS
CMD ["-b", "0.0.0.0", "-Djboss.http.port=8080", "-Djboss.https.port=8443", "-Djboss.http.port.proxy=80", "-Djboss.https.port.proxy=443", "-Djboss.proxy.conf.file=/opt/jboss/keycloak/proxy.conf"]

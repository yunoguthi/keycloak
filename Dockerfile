# Use a base image do Keycloak
FROM quay.io/keycloak/keycloak:latest as builder
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

WORKDIR /opt/keycloak
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=dev.trf3.jus.br" -alias dev.trf3.jus.br -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/dev.trf3.jus.br.keystore
RUN /opt/keycloak/bin/kc.sh build

ENV KC_HOSTNAME=localhost
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

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

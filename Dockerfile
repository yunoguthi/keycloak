#FROM quay.io/keycloak/keycloak:latest as builder

#RUN /opt/keycloak/bin/kc.sh build

##FROM yunoguthi/keycloak-tls:latest

# Use uma imagem de base do Keycloak
FROM quay.io/keycloak/keycloak:16.0.0

#COPY --from=builder /opt/keycloak/ /opt/keycloak/

##WORKDIR /opt/keycloak

# Copie seus arquivos de certificado e chave privada para a imagem do Docker
##COPY cert.pem /etc/x509/https/tls.crt
##COPY decrypted-key.pem /etc/x509/https/tls.key

USER root
##RUN chmod 600 /etc/x509/https/*

# Configurar o Keycloak para usar HTTPS
ENV KC_HTTPS_CERTIFICATE_FILE=/etc/x509/https/tls.crt
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/etc/x509/https/tls.key
ENV KC_HOSTNAME=localhost
# (Opcional) Configurar outras opções de HTTPS
ENV KC_HTTPS_PORT=8443
# ENV KC_HTTPS_PROTOCOLS=TLSv1.3
# ENV KC_HTTPS_CIPHER_SUITES=<ciphers>
# ENV KC_HTTPS_CLIENT_AUTH=<none|request|required>
# ENV KC_HTTPS_KEY_STORE_FILE=<path>
# ENV KC_HTTPS_KEY_STORE_PASSWORD=<password>
# ENV KC_HTTPS_TRUST_STORE_FILE=<path>
# ENV KC_HTTPS_TRUST_STORE_PASSWORD=<password>


# for demonstration purposes only, please make sure to use proper certificates in production instead
##COPY server.keystore conf/

# Configure as variáveis de ambiente para a configuração do Keycloak
ENV KEYCLOAK_USER=teste
ENV KEYCLOAK_PASSWORD=teste
ENV PROXY_ADDRESS_FORWARDING=true
ENV KEYCLOAK_ADMIN = admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENV KEYCLOAK_JAVA_OPTS="-Djavax.net.ssl.trustStore=/etc/x509/https/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit -Xmx2g"

##ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]

# Expõe as portas para HTTP e HTTPS
##EXPOSE 8080
##EXPOSE 8443





# Copie seu certificado SSL/TLS e chave privada para a imagem (certifique-se de que os arquivos estão presentes)
# COPY keycloak-tls.crt /etc/ssl/certs/tls.crt
# COPY keycloak-tls.key /etc/ssl/certs/tls.key

COPY cert.pem /etc/x509/https/tls.crt
COPY decrypted-key.pem /etc/x509/https/tls.key
COPY cert.pem /etc/ssl/certs/tls.crt
COPY decrypted-key.pem /etc/ssl/certs/tls.key

# Defina a senha do keystore para o Keycloak (substitua 'sua-senha' pela senha real)
 ENV KEYCLOAK_HTTPS_KEYSTORE_PASSWORD=sua-senha

# Exponha as portas HTTP (8080) e HTTPS (8443) do Keycloak
EXPOSE 8080 8443

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]


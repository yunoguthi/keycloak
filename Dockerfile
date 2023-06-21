FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Copie seus arquivos de certificado e chave privada para a imagem do Docker
COPY jfsp.csr /etc/x509/https/tls.crt
COPY jfsp.pem /etc/x509/https/tls.key

# Configurar o Keycloak para usar HTTPS
ENV KC_HTTPS_CERTIFICATE_FILE=/etc/x509/https/tls.crt
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/etc/x509/https/tls.key

# (Opcional) Configurar outras opções de HTTPS
ENV KC_HTTPS_PORT=8443
# ENV KC_HTTPS_PROTOCOLS=TLSv1.3
# ENV KC_HTTPS_CIPHER_SUITES=<ciphers>
# ENV KC_HTTPS_CLIENT_AUTH=<none|request|required>
# ENV KC_HTTPS_KEY_STORE_FILE=<path>
# ENV KC_HTTPS_KEY_STORE_PASSWORD=<password>
# ENV KC_HTTPS_TRUST_STORE_FILE=<path>
# ENV KC_HTTPS_TRUST_STORE_PASSWORD=<password>

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
COPY server.keystore conf/

RUN /opt/keycloak/bin/kc.sh build
# Configure as variáveis de ambiente para a configuração do Keycloak
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV PROXY_ADDRESS_FORWARDING=true

# Expõe as portas para HTTP e HTTPS
EXPOSE 8080
EXPOSE 8443

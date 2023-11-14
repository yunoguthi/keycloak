FROM quay.io/keycloak/keycloak:21.0.0
LABEL version="1.0"
LABEL description="Custom Keycloak 21 Image"
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

FROM jboss/keycloak:16.0.0

EXPOSE 8080
EXPOSE 8443
 
COPY keycloak.crt /etc/x509/https/tls.crt
COPY keycloak.key /etc/x509/https/tls.key

#ENV KEYCLOAK_USER=teste
#ENV KEYCLOAK_PASSWORD=teste
ENV PROXY_ADDRESS_FORWARDING=true
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

#CMD ["-b", "0.0.0.0"]

RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh -r master -u admin -p admin

CMD ["-b", "0.0.0.0", "--server-config", "standalone-ha.xml", "-Djboss.socket.binding.port-offset=100", "-Dkeycloak.profile.feature.upload_scripts=enabled", "-Dkeycloak.profile.feature.scripts=enabled"]

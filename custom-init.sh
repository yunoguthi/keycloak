#!/bin/bash

# Esperar pelo Keycloak estar pronto para aceitar conexões
until curl -sSf http://localhost:8080; do
    echo 'Aguardando Keycloak iniciar...'
    sleep 5
done

# Adicionar o usuário admin
/opt/jboss/keycloak/bin/add-user-keycloak.sh -r master -u admin -p admin

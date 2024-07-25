#!/bin/bash
set -o allexport
source .env
set +o allexport
. ${INTEGRATION_PATH}/_network_functions
echo $KONG_DB_PW

(set -e

  (set -x
    # Tear down environment if it is running
    docker-compose -f ${INTEGRATION_PATH}/docker-compose.yml down 
    docker build --build-arg KONG_BASE_TAG=${KONG_BASE_TAG} -t ${BUILD_IMG_NAME}:${KONG_TAG} -f ${INTEGRATION_PATH}/Dockerfile .
    docker-compose -f ${INTEGRATION_PATH}/docker-compose.yml up -d kong-db
  )

  _wait_for_listener integration-kong-db-1:${KONG_DB_PORT}

  (set -x
    docker-compose -f ${INTEGRATION_PATH}/docker-compose.yml run --rm kong kong migrations bootstrap
    docker-compose -f ${INTEGRATION_PATH}/docker-compose.yml up -d
  )

  _wait_for_endpoint http://integration-kong-1:${KONG_HTTP_ADMIN_PORT}
  _wait_for_endpoint http://integration-keycloak-1:${KEYCLOAK_PORT}

  (set -x
    python3 ${INTEGRATION_PATH}/setup.py
  )
)
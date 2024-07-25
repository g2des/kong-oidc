# Note: You can use any Debian/Ubuntu based image you want. 
FROM mcr.microsoft.com/devcontainers/base:bullseye

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends lua5.1 python3 python3-pip 

RUN pip3 install requests

ENV KEYCLOAK_HOST=integration-keycloak-1
ENV KONG_HOST=integration-kong-1
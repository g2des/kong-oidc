FROM kong:3.7.1-ubuntu

# Ensure any patching steps are executed as root user
USER root

# Add custom plugin to the image
RUN apt-get upgrade && apt-get update -y && apt-get install -y curl
COPY /kong/plugins/kong-oidc /usr/local/share/lua/5.1/kong/plugins/kong-oidc
RUN  luarocks install lua-resty-openidc
ENV KONG_PLUGINS=bundled,kong-oidc

# Ensure kong user is selected for image execution
USER kong

# Run kong
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
CMD ["kong", "docker-start"]

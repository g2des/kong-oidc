ARG KONG_BASE_TAG
FROM kong:${KONG_BASE_TAG}

USER root

# ENV LUA_PATH /usr/local/share/lua/5.1/?.lua;/usr/local/kong-oidc/?.lua
# For lua-cjson
# ENV LUA_CPATH /usr/local/lib/lua/5.1/?.so

# Install unzip for luarocks, gcc for lua-cjson
RUN apt-get upgrade && apt-get update -y && apt-get install -y curl gcc unzip
# RUN luarocks install luacov
# RUN luarocks install luaunit
# RUN luarocks install lua-cjson

# Change openidc version when version in rockspec changes
RUN luarocks install lua-resty-openidc 1.6.0

COPY /kong/plugins/oidc /usr/local/share/lua/5.1/kong/plugins/kong-oidc
ENV KONG_PLUGINS=bundled,kong-oidc
# Ensure kong user is selected for image execution
USER kong

# Run kong
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
CMD ["kong", "docker-start"]
ARG KONG_BASE_TAG
FROM kong:${KONG_BASE_TAG}

USER root
RUN apt-get update &&  apt-get install -y unzip gcc

# ENV LUA_PATH /usr/local/share/lua/5.1/?.lua;/usr/local/kong-oidc/?.lua
# For lua-cjson
ENV LUA_CPATH /usr/local/lib/lua/5.1/?.so

# Install unzip for luarocks, gcc for lua-cjson
RUN luarocks install luacov
RUN luarocks install luaunit
RUN luarocks install lua-cjson

# Change openidc version when version in rockspec changes
RUN luarocks install lua-resty-openidc 1.6.1-1

USER kong

WORKDIR /usr/local/kong-oidc

COPY . .

# Run kong
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
CMD ["kong", "docker-start"]

FROM nginx:stable-alpine

# default listener port
ENV NGINX_PORT=8080
ENV REDIRECT_HOST=www.acmecorp.org
ENV REDIRECT_SCHEME=https

# allow customisation of the "Host" header that will passed to the upstream
ENV NGINX_SET_HEADER_HOST='$host'

RUN rm /etc/nginx/conf.d/* && mkdir /etc/nginx/templates
COPY *.template /etc/nginx/templates/.

COPY nginx.conf /etc/nginx/nginx.conf

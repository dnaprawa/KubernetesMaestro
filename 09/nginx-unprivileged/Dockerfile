ARG NGINX_VER=1.20.0    
FROM nginx:${NGINX_VER} 

RUN groupadd -g 10001 app && \
    useradd -u 10000 -g app app \
    && mkdir -p /var/run/nginx /var/tmp/nginx \
    && chown -R app:app /usr/share/nginx /var/run/nginx /var/tmp/nginx

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/
COPY ./index.html /usr/share/nginx/html/

USER app:app

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
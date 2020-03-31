FROM nginx:latest
COPY ./_book /usr/share/nginx/html
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
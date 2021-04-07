FROM nginx:1.19.2-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY static/ /usr/share/nginx/html/static

VOLUME ["/usr/share/nginx/html/media"]

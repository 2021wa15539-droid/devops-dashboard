FROM nginx:alpine
COPY src/templates/index.html /usr/share/nginx/html/index.html

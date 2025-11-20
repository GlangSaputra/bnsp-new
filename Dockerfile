FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 88
CMD ["nginx", "-g", "daemon off;"]

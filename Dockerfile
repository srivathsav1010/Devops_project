# Use Nginx base image
FROM nginx:alpine

# Copy HTML file to Nginx web directory
COPY index.html /usr/share/nginx/html/index.html

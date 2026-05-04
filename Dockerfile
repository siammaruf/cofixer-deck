FROM httpd:2.4-alpine

# Copy website files
COPY . /usr/local/apache2/htdocs/

# Configure Apache for .htaccess support and suppress ServerName warning
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authn_file_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule auth_basic_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authz_user_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd-foreground"]

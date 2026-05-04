FROM httpd:2.4-alpine

# Copy website files
COPY . /usr/local/apache2/htdocs/

# Create custom Apache config that enables .htaccess and loads all required modules
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule mpm_event_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authn_file_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule auth_basic_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authz_user_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authz_core_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule authz_host_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule access_compat_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule log_config_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule unixd_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule alias_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule dir_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule mime_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /usr/local/apache2/conf/httpd.conf

# Change Apache to listen on port 3000
RUN sed -i 's/Listen 80/Listen 3000/g' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's/:80/:3000/g' /usr/local/apache2/conf/httpd.conf

EXPOSE 3000
CMD ["httpd-foreground"]

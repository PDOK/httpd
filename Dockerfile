FROM debian:stretch

MAINTAINER PDOK dev <pdok@kadaster.nl>

# set correct timezone
ENV TZ Europe/Amsterdam

# Install curl for grafana database configuration in init.sh
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

# Set apache variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Copy apache security configuration
COPY configuration-files/security.conf /etc/apache2/conf-enabled/security.conf

# Copy apache configuration
COPY configuration-files/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN mkdir /etc/httpd

RUN a2enmod rewrite
RUN a2ensite 000-default.conf

# Copy default page
COPY www/html/ /var/www/html/
RUN chmod -R 755 /var/www/
RUN chown -R www-data: /var/www/

# Expose required ports
EXPOSE 80

CMD ["apache2ctl","-f","/etc/apache2/apache2.conf","-DFOREGROUND"]
FROM php:7.4-apache

# Instala as dependências necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libmcrypt-dev \
    libzip-dev zlib1g-dev libonig-dev libpq-dev \
    mariadb-client \
    git unzip

# Configura as extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Baixa e instala o MantisBT no diretório /var/www/html
RUN curl -L https://sourceforge.net/projects/mantisbt/files/latest/download -o mantisbt.zip \
    && unzip mantisbt.zip -d /var/www/html/ \
    && rm mantisbt.zip \
    && mv /var/www/html/mantisbt-*/* /var/www/html/ \
    && rm -rf /var/www/html/mantisbt-*/

# Ajusta as permissões dos arquivos para o Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exposição da porta 80 para o Apache
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]
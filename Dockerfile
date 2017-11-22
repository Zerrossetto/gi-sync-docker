###############################################################################
# Dockerfile to build a PHP server with yaml module enabled
# Follows the guide Docker-library guide for PHP module
# https://github.com/docker-library/docs/tree/master/php#pecl-extensions
###############################################################################

FROM webdevops/php-apache-dev:7.1

MAINTAINER Zerrossetto

################## BEGIN INSTALLATION #########################################

RUN apt-get update && apt-get install -y php-pear libyaml-0-2 libyaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml

##################### INSTALLATION END ########################################

#!/bin/bash

SHELL=/bin/bash
DEBIAN_FRONTEND=noninteractive 

BASEDIR=$(dirname $0)

NEW_USER='fruela'
NEW_USER_PWD='1234'
MYSQL_ROOT_PWD='1234'

GIT_USER='Fruela Pérez'
GIT_EMAIL='fruela.perez@protonmail.com'

GETH_VERSION='1.9.6-bd059680'
GOACCESS_VERSION='1.3'
GO_VERSION='1.13.7'
PHPMYADMIN_VERSION='4.9.4'
MEDIAWIKI_VERSION='1.34.0'
MEDIAWIKI_DESTINO='/var/www/html/mediawiki'

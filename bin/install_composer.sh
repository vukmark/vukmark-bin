#!/bin/bash

cd /tmp

wget https://composer.github.io/installer.sig
curl -sS https://getcomposer.org/installer -o composer-setup.php

EXPECTED_SIGNATURE=$(cat installer.sig)
ACTUAL_SIGNATURE=$(php -r "echo hash_file('sha384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature for composer-setup.php'
        rm composer-setup.php
        exit 1
fi

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RESULT=$?
rm composer-setup.php
rm installer.sig

exit $RESULT
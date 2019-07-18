#!/bin/bash

# Install https://github.com/joomlatools/joomlatools-console
composer global require joomlatools/console

# Setup PHP CodeSniffer https://docs.joomla.org/Joomla_CodeSniffer
composer global require squizlabs/php_codesniffer "~2.8"
composer global require joomla/coding-standards "~2.0@alpha"
phpcs --config-set installed_paths "$HOME/.composer/vendor/joomla/coding-standards"
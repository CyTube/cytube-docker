#!/bin/sh

cp ./sync/config.template.yaml ./config.yaml
echo "\e[32m Success! Config file copied! Please update the config to match the settings specific to your application."
cp -R ./sync/conf ./conf
echo "\e[32m Success! Auxillary config files copied to ./conf/example/. Please update these config files and move them to ./conf if you plan on using them."

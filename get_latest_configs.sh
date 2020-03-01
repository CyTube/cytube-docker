#bin/bash

wget -q -O config.template.yaml https://raw.githubusercontent.com/calzoneman/sync/3.0/config.template.yaml
mv config.template.yaml config.yaml
echo -e "\e[32m Success! Config file downloaded from github and copied to config.yaml. Please update the config to match the settings specific to your application."
mkdir conf
mkdir conf/example
wget -q -O camo.toml https://raw.githubusercontent.com/calzoneman/sync/3.0/conf/example/camo.toml
mv camo.toml ./conf/example/
wget -q -O email.toml https://raw.githubusercontent.com/calzoneman/sync/3.0/conf/example/email.toml
mv email.toml ./conf/example/
wget -q -O prometheus.toml https://raw.githubusercontent.com/calzoneman/sync/3.0/conf/example/prometheus.toml
mv prometheus.toml ./conf/example
echo -e "\e[32m Success! Auxillary config files downloaded from github and copied to ./conf/example. Please update these config files and move them to ./conf if you plan on using them."

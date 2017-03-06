#!/bin/bash

# When you change this file, you must take manual action. Read this doc:
# - https://docs.sandstorm.io/en/latest/vagrant-spk/customizing/#setupsh

set -euo pipefail
# This is the ideal place to do things like:
#
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y git g++ automake libtool pkg-config
apt-get install -y nginx php5-fpm php5-mysql php5-sqlite php5-curl php5-gd


exit 0

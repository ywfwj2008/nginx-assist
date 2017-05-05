#!/bin/bash

KODEXPLORER_VERSION=3.46
PHPMYADMIN_VERSION=4_7_0
PHPMYADMIN2_VERSION=4_4_15_10
DEFAULT_DIR=/home/wwwroot/default

# install kodexplorer
wget --no-check-certificate -c -P /tmp http://static.kalcaddle.com/update/download/kodexplorer${KODEXPLORER_VERSION}.zip
unzip /tmp/kodexplorer${KODEXPLORER_VERSION}.zip -d ${DEFAULT_DIR}/kod
unlink /tmp/kodexplorer${KODEXPLORER_VERSION}.zip
chown -R 1000:1000 ${DEFAULT_DIR}/kod

# install phpmyadmin
wget --no-check-certificate -c -P /tmp https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_${PHPMYADMIN_VERSION}.zip
unzip /tmp/RELEASE_${PHPMYADMIN_VERSION}.zip -d ${DEFAULT_DIR}
mv ${DEFAULT_DIR}/phpmyadmin-RELEASE_${PHPMYADMIN_VERSION} ${DEFAULT_DIR}/pma
unlink /tmp/RELEASE_${PHPMYADMIN_VERSION}.zip
chown -R 1000:1000 ${DEFAULT_DIR}/pma

#!/bin/bash

KODEXPLORER_VERSION=3.37
PHPMYADMIN_VERSION=4_6_5_2

wget --no-check-certificate -c -P /tmp http://static.kalcaddle.com/update/download/kodexplorer${KODEXPLORER_VERSION}.zip
unzip /tmp/kodexplorer3.37.zip -d /home/wwwroot/default/kod

wget --no-check-certificate -c -P /tmp https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_${PHPMYADMIN_VERSION}.zip
unzip /tmp/RELEASE_4_6_5_2.zip -d /home/wwwroot/default
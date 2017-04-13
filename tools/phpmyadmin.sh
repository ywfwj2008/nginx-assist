#!/bin/bash

# 安装
while :; do echo
  read -p "Do you want to install phpMyAdmin? [y/n]: " Pma_yn
  if [[ ! $Pma_yn =~ ^[y,n]$ ]]; then
    echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
  else
    if [ "$Pma_yn" == 'y' ]; then
      # phpMyAdmin version
      while :; do echo
        echo 'Please select a version:'
        echo -e "\t${CMSG}1${CEND}. phpMyAdmin 4.4"
        echo -e "\t${CMSG}2${CEND}. phpMyAdmin 4.6"
        echo -e "\t${CMSG}3${CEND}. phpMyAdmin 4.7"
        echo -e "\t${CMSG}4${CEND}. Do not run"
        read -p "Please input a number:(Default 2 press Enter) " Choose_number
        [ -z "$Choose_number" ] && Choose_number=2
        if [[ ! $Choose_number =~ ^[1-4]$ ]]; then
          echo "${CWARNING}input error! Please only input number 1,2,3,4${CEND}"
        else
          break
        fi
      done
      case "${Choose_number}" in
        1)
          PHPMYADMIN_VERSION=4.4.15.10
          ;;
        2)
          PHPMYADMIN_VERSION=4.6.6
          ;;
        3)
          PHPMYADMIN_VERSION=4.7.0
          ;;
        4)
          break
          ;;
      esac

      wget https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz
      tar -zxf phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz
      unlink phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz
      rm -rf /home/wwwroot/default/pma
      mv -f phpMyAdmin-$PHPMYADMIN_VERSION-all-languages /home/wwwroot/default/pma

    fi
    break
  fi
done

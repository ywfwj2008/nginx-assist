#!/bin/bash

. ./common.sh

# Run Web server Image
while :; do echo
  read -p "Do you want to run a web image? [y/n]: " Web_yn
  if [[ ! "$Web_yn" =~ ^[y,n]$ ]]; then
    echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
  else
    if [ "$Web_yn" == 'y' ]; then
      # web type
      while :; do echo
        echo 'Please select web type:'
        echo -e "\t${CMSG}1${CEND}. Nginx"
        echo -e "\t${CMSG}2${CEND}. Tengine"
        echo -e "\t${CMSG}3${CEND}. OpenResty"
        echo -e "\t${CMSG}4${CEND}. Do not run"
        read -p "Please input a number:(Default 1 press Enter) " Choose_number
        [ -z "$Choose_number" ] && Choose_number=1
        if [[ ! "$Choose_number" =~ ^[1-4]$ ]]; then
          echo "${CWARNING}input error! Please only input number 1,2,3,4${CEND}"
        else
          break
        fi
      done
      case "${Choose_number}" in
        1)
          WEB_TYPE=nginx
          ;;
        2)
          WEB_TYPE=tengine
          ;;
        3)
          WEB_TYPE=openresty
          ;;
        4)
          break
          ;;
      esac

      # php version
      while :; do echo
        echo 'Please select php version:'
        echo -e "\t${CMSG}1${CEND}. PHP 5.4"
        echo -e "\t${CMSG}2${CEND}. PHP 5.5"
        echo -e "\t${CMSG}3${CEND}. PHP 5.6"
        echo -e "\t${CMSG}4${CEND}. PHP 7.0"
        echo -e "\t${CMSG}5${CEND}. PHP 7.1"
        read -p "Please input a number:(Default 2 press Enter) " Choose_number
        [ -z "$Choose_number" ] && Choose_number=2
        if [[ ! "$Choose_number" =~ ^[1-6]$ ]]; then
          echo "${CWARNING}input error! Please only input number 1,2,3,4,5${CEND}"
        else
          break
        fi
      done
      case "${Choose_number}" in
        1)
          PHP_VERSION=5.4
          ;;
        2)
          PHP_VERSION=5.5
          ;;
        3)
          PHP_VERSION=5.6
          ;;
        4)
          PHP_VERSION=7.0
          ;;
        5)
          PHP_VERSION=7.1
          ;;
      esac

      # container name
      while :; do echo
        read -p "Please input container name:(Default \"web\" press Enter) " Container_name
        [ -z "$Container_name" ] && Container_name=web
        Container_grep=`docker ps -a | grep "\<$Container_name\>$"`
        if [ -n "$Container_grep" ]; then
          echo "${CWARNING}input error! The container's name '$Container_name' already exists.${CEND}"
        else
          break
        fi
      done

      # link mysql
      echo
      read -p "Do you want to link a mysql image? [y/n]: " LinkMy_yn
      if [[ ! "$LinkMy_yn" =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        if [ "$LinkMy_yn" == 'y' ]; then echo
          read -p "Please input link name:(looks like mysql:localmysql) " Link_name
          [ -n ${Link_name} ] &&  CUSTOM_LINK="--link ${Link_name}"
        fi
      fi

      # set ports
      echo
      read -p "Do you want to set ports? [y/n]: " Ports_yn
      if [[ ! "$Ports_yn" =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        if [ "$Ports_yn" == 'y' ]; then echo
          read -p "Please input http port:(Default 80 press Enter) " Port_http
          [ -z "$Port_http" ] && Port_http=80
          echo
          read -p "Please input https port:(Default 443 press Enter) " Port_https
          [ -z "$Port_https" ] && Port_https=443
        fi
      fi

      # run docker image
      echo
      docker run --name ${Container_name} \
           ${CUSTOM_LINK} \
           -v /home/conf/vhost:/usr/local/${WEB_TYPE}/conf/vhost \
           -v /home/conf/rewrite:/usr/local/${WEB_TYPE}/conf/rewrite \
           -v /home/wwwlogs:/home/wwwlogs \
           -v /home/wwwroot:/home/wwwroot \
           -p ${Port_http}:80 -p ${Port_https}:443 \
           -d ywfwj2008/php-${WEB_TYPE}:${PHP_VERSION}
    fi
    break
  fi
done
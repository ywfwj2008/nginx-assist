#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear
printf "
#######################################################################
#       OneinStack for CentOS/RadHat 5+ Debian 6+ and Ubuntu 12+      #
#       For more information please visit https://oneinstack.com      #
#######################################################################
"

# color
echo=echo
for cmd in echo /bin/echo; do
  $cmd >/dev/null 2>&1 || continue
  if ! $cmd -e "" | grep -qE '^-e'; then
    echo=$cmd
    break
  fi
done
CSI=$($echo -e "\033[")
CEND="${CSI}0m"
CDGREEN="${CSI}32m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"
CMAGENTA="${CSI}1;35m"
CCYAN="${CSI}1;36m"
CSUCCESS="$CDGREEN"
CFAILURE="$CRED"
CQUESTION="$CMAGENTA"
CWARNING="$CYELLOW"
CMSG="$CCYAN"

# Run Web server Image
while :; do echo
  read -p "Do you want to run a web image? [y/n]: " Web_yn
  if [[ ! $Web_yn =~ ^[y,n]$ ]]; then
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
        if [[ ! $Choose_number =~ ^[1-6]$ ]]; then
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
      echo
      read -p "Please input a container name:(Default no name press Enter) " Container_name
      [ -n "$Container_name" ] && Container_name="--name ${Container_name}"

      # link mysql
      echo
      read -p "Do you want to link a mysql image? [y/n]: " LinkMy_yn
      if [[ ! $LinkMy_yn =~ ^[y,n]$ ]]; then
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
      if [[ ! $Ports_yn =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        if [ "$Ports_yn" == 'y' ]; then echo
          read -p "Please input http port:(Default 80 press Enter) " Port_http
          [ -z "$Port_http" ] && Port_http=80
          read -p "Please input https port:(Default 443 press Enter) " Port_https
          [ -z "$Port_https" ] && Port_https=443
        fi
      fi

      # run docker image
      echo
      docker run ${Container_name} \
           ${CUSTOM_LINK} \
           -v /home/conf/vhost:/usr/local/nginx/conf/vhost \
           -v /home/conf/rewrite:/usr/local/nginx/conf/rewrite \
           -v /home/wwwlogs:/home/wwwlogs \
           -v /home/wwwroot:/home/wwwroot \
           -p ${Port_http}:80 -p ${Port_https}:443 \
           -d ywfwj2008/php-${WEB_TYPE}:${PHP_VERSION}
    fi
    break
  fi
done
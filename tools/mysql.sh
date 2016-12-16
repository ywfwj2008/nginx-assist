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

# check Web server
while :; do echo
  read -p "Do you want to run a mysql image? [y/n]: " Mysql_yn
  if [[ ! $Mysql_yn =~ ^[y,n]$ ]]; then
    echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
  else
    if [ "$Mysql_yn" == 'y' ]; then
      # Mysql version
      while :; do echo
        echo 'Please select mysql version:'
        echo -e "\t${CMSG}1${CEND}. Mysql 5.5 "
        echo -e "\t${CMSG}2${CEND}. Mysql 5.6"
        echo -e "\t${CMSG}3${CEND}. Mysql 5.7"
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
          MYSQL_VERSION=5.5
          ;;
        2)
          MYSQL_VERSION=5.6
          ;;
        3)
          MYSQL_VERSION=5.7
          ;;
        4)
          break
          ;;
      esac

      # input password
      while :; do echo
        read -p "Please input a password: " MYSQL_ROOT_PASSWORD
        if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
          MY_SECRET_PW="-e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
          break
        fi
      done

      # container name
      echo
      read -p "Please input container name:(Default \"mysql\" press Enter) " Container_name
      [ -z "$Container_name" ] && Container_name=mysql

      # run docker image
      echo
      "docker run --name ${Container_name} \
           -v /home/mysql:/var/lib/mysql \
           ${MY_SECRET_PW} \
           -d mysql:${MYSQL_VERSION}"

    fi
    break
  fi
done
#!/bin/sh


echo -e "\n>>>> Running cmd: 'mysqladmin ping -h mysql_aula04 -u mauricio --password=password' ..."
mysqladmin ping -h mysql_aula04 -u mauricio --password=password

echo -e "\n>>>> Running cmd: 'mysql -h mysql_aula04 -u mauricio --password=password -D impacta -e 'select * from students'' ..."
mysql -h mysql_aula04 -u mauricio --password=password -D impacta -e "select * from students"

echo -e "\n"
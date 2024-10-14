#!/bin/bash

#Diretório para onde vai ficar o log
#Esta parte tem que ser hardcoded, sem a variável $USER, pois o cron dá erro

path=/home/gfaraco/log;
fileOnline=$path/logfileOnline.log;
fileOffline=$path/logfileOffline.log;
outputString="$(date '+%d-%m-%Y %H:%M:%S') -"; 

#Cria o diretório de onde vai ficar o log, se ele não existir

if [ ! -d $path ]; then
	mkdir -p $path
fi

#Cria o arquivo de log no diretório específico, se o arquivo não existir

if [ ! -f $fileOnline  ]; then
	touch $fileOnline;
fi

if [ ! -f $fileOffline  ]; then
	touch $fileOffline;
fi
#Testar se o serviço nginx está online ou offline e tratar a string do output
#Concatenando com a data;
#Se o nginx estiver offline, ele manda o log para o arquivo específico
#Se estiver online, ele manda para o outro arquivo

if service nginx status | grep -q '* nginx is not running'; then
	service="Serviço Nginx está offline";
	echo "$outputString $service" >> $fileOffline;
else 	service="Serviço Nginx está online";
	echo "$outputString $service" >> $fileOnline;
fi




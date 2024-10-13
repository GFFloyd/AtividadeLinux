#!usr/bin/bash

#Diretório para onde vai ficar o log
path=/home/$USER/log;
file=$path/logfile.log;

#Cria o diretório de onde vai ficar o log, se ele não existir
if [ ! -d $path ]; then
	mkdir -p $path
fi

#Cria o arquivo de log no diretório específico, se o arquivo não existir
if [ ! -f $path/logfile.log ]; then
	touch $file;
fi

#Testar se o serviço nginx está online ou offline e tratar a string do outputi
if service nginx status | grep -q '* nginx is not running'; then
	service="Serviço Nginx está offline";
else service="Serviço Nginx está online";
fi

#Depois de validado o output do serviço, concatenar o resultado com a data atual e mandar
#para o arquivo de log
outputString="$(date '+%d-%m-%Y %H:%M:%S') -"; 
echo "$outputString $service" >> $file;


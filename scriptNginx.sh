#!usr/bin/bash

#Diretório para onde vai ficar o log
path=/home/$USER/log;
file=$path/logfile.log;
service=service nginx status;
#Testa para ver se o diretório de onde vai ficar o log existe e se não existir ele é criado
if [ ! -d $path ]; then
	mkdir -p $path
fi

#Cria o arquivo de log no diretório específico
if [ ! -f $path/logfile.log ]; then
	touch $file;
else echo "file not created";
fi

#Testar se o serviço nginx está online ou offline e tratar a string do output
if [ $service == "* " ]


#Depois de validado o output do serviço, concatenar o resultado com a data atual e mandar
#para o arquivo de log
outputString="$(date '+%d-%m-%Y %H:%M:%S') -"; 
echo $outputString >> $file;


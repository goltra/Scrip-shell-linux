#!/bin/bash
###OBTENER ESPACIO OCUPADO###

getdf="df -h $1 | grep $1"
df=`eval $getdf`
getpos="awk 'BEGIN{print index(\"$df\",\"%\")}'"
#echo $getpos
pos=`eval $getpos`
pos=$pos-2
getfreespace="awk 'BEGIN{print substr(\"$df\",$pos,2)}'"
#echo $getfreespace
freespace=`eval $getfreespace`
#echo $pos
#echo $freespace
echo 'Espacio ocupado: ' $freespace '%'
### FIN ESPACIO OCUPADO #####

### OBTENER CORREOS EN COLA ###
getqueue="/var/qmail/bin/qmail-qstat | grep \"messages in queue:\" | cut -d\":\" -f2"
queue=`eval $getqueue`
echo "Correos en Cola: " $queue
### FIN OBTENER CORREOS EN COLA ###
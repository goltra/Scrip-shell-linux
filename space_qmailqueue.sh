#!/bin/bash

### PARAMETROS / CONFIGURACION ###
emailavisos="aaa@gmail.com"
emailavisoscopia="copia@gmail.com"
limiteespacio=90
limitecolaemails=100
### FIN PARAMETROS / CONFIGURACION ###


###OBTENER ESPACIO OCUPADO###
a=$1
carac=${#a}
echo $carac
if [ $carac -gt 0 ] ; then
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
        if [ $freespace -gt $limiteespacio ] ; then
                subject="Espacio límite alcanzado en  $(hostname)"
                message="Se está ocupando el  $freespace  %"
                echo $message  |  /bin/mail -s "$subject" "$emailavisos" -c "$emailavisoscopia"

        fi

fi
### FIN ESPACIO OCUPADO #####

### OBTENER CORREOS EN COLA ###
getqueue="/var/qmail/bin/qmail-qstat | grep \"messages in queue:\" | cut -d\":\" -f2"
queue=`eval $getqueue`
echo "Correos en Cola: " $queue

if [ $queue -gt $limitecolaemails ] ; then
              subject="Muchos correos en la cola de  $(hostname)"
              message="Hay un total de   $queue  correos"
              echo $message  |  /bin/mail -s "$subject" "$emailavisos" -c "$emailavisoscopia"
fi

### FIN OBTENER CORREOS EN COLA ###

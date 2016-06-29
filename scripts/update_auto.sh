#! /bin/bash
#Createur : Paul-Emile ADELIN
#Adresse mail: paul.emileadelin@gmail.com
#Ce script permet d'alimenter les 4 bases RRD :
#			- trafic_eth0.rrd
#			- trafic_tcp.rrd
#			- memoire.rrd
#			- cpu.rrd
#Ce script est a ajouter dans /etc/crontab sous la forme :
#* * * * * root /var/www/rrdtool/update_auto.sh >/dev/null


date_immediate=$(date +%s)
Machine=$(echo "$HOSTNAME")
ICI=/var/www/projet-citevolcan
doss_image="$ICI/graphs/"
doss_rrd="$ICI/rrdtool/"
mkdir -p $doss_image
mkdir -p $doss_rrd

rrdtool update $(echo $doss_rrd)trafic_eth0.rrd $(grep eth0 /proc/net/dev | cut -d: -f2 | awk -v ts=`date +\%s` '{print ts":"$1":"$9}') && rrdtool update $(echo $doss_rrd)trafic_tcp.rrd $(echo $(netstat -tan | wc -l && netstat -tan | grep ESTABLISHED | wc -l) | awk -v ts=`date +\%s` '{print ts":"$1":"$2}') && rrdtool update $(echo $doss_rrd)cpu.rrd $(uptime | cut -d: -f5 | tr ',' ' ' | awk -v ts=`date +\%s` '{print ts":"$1$2":"$3$4":"$5$6}') && rrdtool update $(echo $doss_rrd)memoire.rrd $(grep Mem /proc/meminfo | cut -d: -f2 | tr 'kB\n' ' ' | awk -v ts=`date +\%s` '{print ts":"$1":"$2":"$3}')

if [ $? -gt 0 ]; 
  then
    echo "Erreur lors de la mise à jour des RDD"

    else
    echo "Les RDD ont été mise à jour avec succès"
fi


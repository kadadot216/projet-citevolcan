#! /bin/bash
#Createur : Paul-Emile ADELIN
#Adresse mail: paul.emileadelin@gmail.com
#Ce script permet de tracer les graphes des 4 bases RRD :
#			- trafic_eth0.rrd
#			- trafic_tcp.rrd
#			- memoire.rrd
#			- cpu.rrd
#Ce script est a ajouter dans /etc/crontab sous la forme :
#* * * * * root /var/www/rrdtool/graphes.sh >/dev/null

cat << FIN
========= RRDTools Tool =========
Création des graphes
=================================
FIN
date_immediate=$(date +%s)
Machine=$(echo "$HOSTNAME")
ICI=$(pwd)
doss_image="$ICI/../graphs/"
doss_rrd="$ICI/../rrdtool/"
mkdir -p $doss_image
mkdir -p $doss_rrd


		#Graphe eth0 3 Heures
	    max_reception=8000
	    max_emission=800
		nom=trafic_eth0
		unite="Ko/s"
		vertical="Débit ($unite)"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic eth0 sur 3 Heures ($derniere_date)"
		image="$doss_image$nom-3h.png"
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:rx=$nom_RRD:rx:LAST \
		DEF:tx=$nom_RRD:tx:LAST \
		HRULE:$max_reception#00aa55:"Maximum théorique réception ($max_reception $unite)\l" \
		HRULE:$max_emission#009922:"Maximum théorique émission ($max_emission $unite)\l" \
		COMMENT:"\r" \
		CDEF:realrx=rx,1000,/ \
		AREA:realrx#00ff00:"RX" \
		GPRINT:realrx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realrx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realtx=tx,1000,/ \
		AREA:realtx#00aa00:"TX" \
		GPRINT:realtx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"
#		eog $image 2>/dev/null &

		#Graphe eth0 1 Jour
	    max_reception=8000
	    max_emission=800
		nom=trafic_eth0
		unite="Ko/s"
		vertical="Débit ($unite)"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic eth0 sur 1 Jour ($derniere_date)"
		image="$doss_image$nom-1d.png"
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:rx=$nom_RRD:rx:LAST \
		DEF:tx=$nom_RRD:tx:LAST \
		HRULE:$max_reception#00aa55:"Maximum théorique réception ($max_reception $unite)\l" \
		HRULE:$max_emission#009922:"Maximum théorique émission ($max_emission $unite)\l" \
		COMMENT:"\r" \
		CDEF:realrx=rx,1000,/ \
		AREA:realrx#00ff00:"RX" \
		GPRINT:realrx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realrx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realtx=tx,1000,/ \
		AREA:realtx#00aa00:"TX" \
		GPRINT:realtx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"

		#Graphe eth0 1 Semaine
	    max_reception=8000
	    max_emission=800
		nom=trafic_eth0
		unite="Ko/s"
		vertical="Débit ($unite)"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic eth0 sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 --start -604800 -t "$titre" \
		DEF:rx=$nom_RRD:rx:LAST \
		DEF:tx=$nom_RRD:tx:LAST \
		HRULE:$max_reception#00aa55:"Maximum théorique réception ($max_reception $unite)\l" \
		HRULE:$max_emission#009922:"Maximum théorique émission ($max_emission $unite)\l" \
		COMMENT:"\r" \
		CDEF:realrx=rx,1000,/ \
		AREA:realrx#00ff00:"RX" \
		GPRINT:realrx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realrx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realtx=tx,1000,/ \
		AREA:realtx#00aa00:"TX" \
		GPRINT:realtx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"

		#Graphe Trafic TCP sur 3 Heures
		nom=trafic_tcp
		unite=""
		vertical="Nombre de connexions TCP"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic TCP sur 3 Heures ($derniere_date)"
		image="$doss_image$nom-3h.png"
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:established=$nom_RRD:established:LAST \
		COMMENT:"\r" \
		CDEF:realtotal=total,1000000,/ \
		AREA:realtotal#00ff00:"Total" \
		GPRINT:realtotal:MAX:"\tMax\: %2.0lf " \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		CDEF:realestablished=established,1000000,/ \
		AREA:realestablished#00aa00:"Established" \
		GPRINT:realestablished:MAX:"\tMax\: %2.0lf" \
		GPRINT:realestablished:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		COMMENT:"Informations sur les connexions réseau sur $Machine\r"

		#Graphe Trafic TCP sur 1 Jour
		nom=trafic_tcp
		unite=""
		vertical="Nombre de connexions TCP"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic TCP sur 1 Jour ($derniere_date)"
		image="$doss_image$nom-1d.png"
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:established=$nom_RRD:established:LAST \
		COMMENT:"\r" \
		CDEF:realtotal=total,1000000,/ \
		AREA:realtotal#00ff00:"Total" \
		GPRINT:realtotal:MAX:"\tMax\: %2.0lf " \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		CDEF:realestablished=established,1000000,/ \
		AREA:realestablished#00aa00:"Established" \
		GPRINT:realestablished:MAX:"\tMax\: %2.0lf" \
		GPRINT:realestablished:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		COMMENT:"Informations sur les connexions réseau sur $Machine\r"

		#Graphe Trafic TCP sur 1 Semaine
		nom=trafic_tcp
		unite=""
		vertical="Nombre de connexions TCP"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic TCP sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -604800 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:established=$nom_RRD:established:LAST \
		COMMENT:"\r" \
		CDEF:realtotal=total,1000000,/ \
		AREA:realtotal#00ff00:"Total" \
		GPRINT:realtotal:MAX:"\tMax\: %2.0lf " \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		CDEF:realestablished=established,1000000,/ \
		AREA:realestablished#00aa00:"Established" \
		GPRINT:realestablished:MAX:"\tMax\: %2.0lf" \
		GPRINT:realestablished:AVERAGE:"\tMoyenne\: %2.0lf \l" \
		COMMENT:"Informations sur les connexions réseau sur $Machine\r"

		#Graphe CPU Sur 3 Heures
		nom=cpu
		unite=""
		vertical="Load average"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Charge système sur 3 Heures ($derniere_date)"
		image="$doss_image$nom-3h.png"
		CPU=$(grep "model name" /proc/cpuinfo | cut -d: -f2)
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:1mn=$nom_RRD:1min:AVERAGE \
		DEF:5mn=$nom_RRD:5min:AVERAGE \
		DEF:15mn=$nom_RRD:15min:AVERAGE \
		AREA:1mn#00c9e4:"1 min" \
		GPRINT:1mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:1mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:5mn#0097a0:"5 min" \
		GPRINT:5mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:5mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:15mn#003d4f:"15 min" \
		GPRINT:15mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:15mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:500#ffb921:"avertissement\l" \
		HRULE:1000#ff0000:"alerte\l" \
		COMMENT:"Charge système \: $CPU sur $Machine\r"
#		eog $image 2>/dev/null &

		#Graphe CPU Sur 1 Jour
		nom=cpu
		unite=""
		vertical="Load average"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Charge système sur 1 Jour ($derniere_date)"
		image="$doss_image$nom-1d.png"
		CPU=$(grep "model name" /proc/cpuinfo | cut -d: -f2)
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:1mn=$nom_RRD:1min:AVERAGE \
		DEF:5mn=$nom_RRD:5min:AVERAGE \
		DEF:15mn=$nom_RRD:15min:AVERAGE \
		AREA:1mn#00c9e4:"1 min" \
		GPRINT:1mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:1mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:5mn#0097a0:"5 min" \
		GPRINT:5mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:5mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:15mn#003d4f:"15 min" \
		GPRINT:15mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:15mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:500#ffb921:"avertissement\l" \
		HRULE:1000#ff0000:"alerte\l" \
		COMMENT:"Charge système \: $CPU sur $Machine\r"
#		eog $image 2>/dev/null &

		#Graphe CPU Sur 1 Semaine
		nom=cpu
		unite=""
		vertical="Load average"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Charge système sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		CPU=$(grep "model name" /proc/cpuinfo | cut -d: -f2)
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -604800 -t "$titre" \
		DEF:1mn=$nom_RRD:1min:AVERAGE \
		DEF:5mn=$nom_RRD:5min:AVERAGE \
		DEF:15mn=$nom_RRD:15min:AVERAGE \
		AREA:1mn#00c9e4:"1 min" \
		GPRINT:1mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:1mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:5mn#0097a0:"5 min" \
		GPRINT:5mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:5mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		AREA:15mn#003d4f:"15 min" \
		GPRINT:15mn:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:15mn:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:500#ffb921:"avertissement\l" \
		HRULE:1000#ff0000:"alerte\l" \
		COMMENT:"Charge système \: $CPU sur $Machine\r"
#		eog $image 2>/dev/null &
		
		#Graphe memoire sur 3 Heures
		nom=memoire
		unite="Mo"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 3 Heures($derniere_date)"
		image="$doss_image$nom-3h.png"
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		DEF:avaible=$nom_RRD:avaible:LAST \
		CDEF:realtotal=total,1000,/ \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:realtotal:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realfree=free,1000,/ \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:realfree:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realfree:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realavaible=avaible,1000,/ \
		LINE2:avaible#7f9ac8:"Mem. Disponible " \
		GPRINT:realavaible:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realavaible:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
		#eog $image 2>/dev/null &

		#Graphe memoire sur 1 Jour	
		nom=memoire
		unite="Mo"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 1 Jour($derniere_date)"
		image="$doss_image$nom-1d.png"
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		DEF:avaible=$nom_RRD:avaible:LAST \
		CDEF:realtotal=total,1000,/ \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:realtotal:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realfree=free,1000,/ \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:realfree:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realfree:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realavaible=avaible,1000,/ \
		LINE2:avaible#7f9ac8:"Mem. Disponible " \
		GPRINT:realavaible:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realavaible:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
		#eog $image 2>/dev/null &

		#Graphe memoire sur 1 Semaine	
		nom=memoire
		unite="Mo"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -604800 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		DEF:avaible=$nom_RRD:avaible:LAST \
		CDEF:realtotal=total,1000,/ \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:realtotal:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realtotal:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realfree=free,1000,/ \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:realfree:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realfree:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		CDEF:realavaible=avaible,1000,/ \
		LINE2:avaible#7f9ac8:"Mem. Disponible " \
		GPRINT:realavaible:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:realavaible:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
#		eog $image 2>/dev/null &

if [ $? -gt 0 ]; 
  then
    echo "Erreur lors de la création des graphes"

    else
    echo "Les graphes ont été crées avec succès"
fi
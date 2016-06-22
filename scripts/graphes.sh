#! /bin/bash
clear
cat << FIN
========= RRDTools Tool =========
Création des graphes
=================================
FIN
date_immediate=$(date +%s)
Machine=$(echo "$HOSTNAME")
ICI=/home/syls/Bureau/base_rrdtool/superviser
doss_image="$ICI/graphs/"
doss_rrd="$ICI/rrdtools/"
mkdir -p $doss_image
mkdir -p $doss_rrd



		#Graphe eth0 3 Heures
	    max_reception=8000000
	    max_emission=800000
		nom=trafic_eth0
		unite="B/s"
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
		AREA:rx#00ff00:"RX" \
		GPRINT:rx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:rx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:tx#00aa00:"TX" \
		GPRINT:tx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:tx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"
		eog $image 2>/dev/null &

		#Graphe eth0 1 Jour
	    max_reception=8000000
	    max_emission=800000
		nom=trafic_eth0
		unite="B/s"
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
		AREA:rx#00ff00:"RX" \
		GPRINT:rx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:rx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:tx#00aa00:"TX" \
		GPRINT:tx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:tx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"
		eog $image 2>/dev/null &

		#Graphe eth0 1 Semaine
	    max_reception=8000000
	    max_emission=800000
		nom=trafic_eth0
		unite="B/s"
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
		AREA:rx#00ff00:"RX" \
		GPRINT:rx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:rx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:tx#00aa00:"TX" \
		GPRINT:tx:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:tx:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"Trafic de l'interface réseau sur $Machine\r"
		eog $image 2>/dev/null &

		#Graphe Température sur 3 Heures
		nom=temperature
		unite="°C"
		vertical="Température CPU ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Température sur 3 Heures ($derniere_date)"
		image="$doss_image$nom-3h.png"
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:temp=$nom_RRD:temp:MAX \
		AREA:temp#DD0000:"Température" \
		GPRINT:temp:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:temp:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:60#aa0000:"avertissement\l" \
		HRULE:70#550000:"alerte\l" \
		COMMENT:"Température CPU sur $Machine\r"
#		eog $image 2>/dev/null &
		
		#Graphe Température sur 1 Jour
		nom=temperature
		unite="°C"
		vertical="Température CPU ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Température Sur 1 Jour ($derniere_date)"
		image="$doss_image$nom-1d.png"
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:temp=$nom_RRD:temp:MAX \
		AREA:temp#DD0000:"Température" \
		GPRINT:temp:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:temp:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:60#aa0000:"avertissement\l" \
		HRULE:70#550000:"alerte\l" \
		COMMENT:"Température CPU sur $Machine\r"
#		eog $image 2>/dev/null &

		#Graphe Température sur 1 Semaine
		nom=temperature
		unite="°C"
		vertical="Température CPU ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Température Sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -604800 -t "$titre" \
		DEF:temp=$nom_RRD:temp:MAX \
		AREA:temp#DD0000:"Température" \
		GPRINT:temp:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:temp:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:60#aa0000:"avertissement\l" \
		HRULE:70#550000:"alerte\l" \
		COMMENT:"Température CPU sur $Machine\r"
#		eog $image 2>/dev/null &

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
		HRULE:0.5#ffb921:"avertissement\l" \
		HRULE:1#ff0000:"alerte\l" \
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
		HRULE:0.5#ffb921:"avertissement\l" \
		HRULE:1#ff0000:"alerte\l" \
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
		HRULE:0.5#ffb921:"avertissement\l" \
		HRULE:1#ff0000:"alerte\l" \
		COMMENT:"Charge système \: $CPU sur $Machine\r"
#		eog $image 2>/dev/null &
		
		#Graphe memoire sur 3 Heures
		nom=memoire
	    #max_reception=8000000
	    #max_emission=800000		
		unite="kB"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 3 Heures($derniere_date)"
		image="$doss_image$nom-3h.png"
		echo "Création de l'image $nom-3h :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:total:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:total:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:free:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:free:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
		#eog $image 2>/dev/null &

		#Graphe memoire sur 1 Jour	
		nom=memoire
	    #max_reception=8000000
	    #max_emission=800000		
		unite="kB"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 1 Jour($derniere_date)"
		image="$doss_image$nom-1d.png"
		echo "Création de l'image $nom-1d :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -86400 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:total:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:total:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:free:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:free:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
		#eog $image 2>/dev/null &

		#Graphe memoire sur 1 Semaine	
		nom=memoire
	    #max_reception=8000000
	    #max_emission=800000		
		unite="kB"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM sur 1 Semaine ($derniere_date)"
		image="$doss_image$nom-1w.png"
		echo "Création de l'image $nom-1w :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E --start -604800 -t "$titre" \
		DEF:total=$nom_RRD:total:LAST \
		DEF:free=$nom_RRD:free:LAST \
		AREA:total#c8ad7f:"Mem. totale" \
		GPRINT:total:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:total:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		AREA:free#f0c300:"Mem. libre " \
		GPRINT:free:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:free:AVERAGE:"\tMoyenne\: %.2lf $unite\l" \
		COMMENT:"\r" \
		COMMENT:"Utilisation de la mémoire par le système sur $Machine\r"
		#eog $image 2>/dev/null &

if [ $? -gt 0 ]; 
  then
    echo "Erreur lors de la création des graphes"

    else
    echo "Les graphes ont été crées avec succès"
fi
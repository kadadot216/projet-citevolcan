#! /bin/bash
clear
cat << FIN
========= RRDTools Tool =========
Choisissez parmi ces modes :
a) Créer la base de données
z) Alimenter la base de données
e) Afficher le graphe
r) Quitter
=================================
FIN
date_immediate=$(date +%s)
Machine=$(echo "$HOSTNAME")
ICI=$(cd $(dirname "$0") && pwd)
doss_image="$ICI/graphs/"
doss_rrd="$ICI/rrdtools/"
mkdir -p $doss_image
mkdir -p $doss_rrd

read touche
case "$touche" in
	a)		#création d'une RRD (fichier de base de donnée) pour log de trafic sur eth0 :
			#création d'une DataSource de type compteur pour le nombre d'octets reçus :
			#DS pour les octets transmis avec heartbeat (si passé ce délai,valeur=Unknown):borne mini:borne maxi (U==Unknown)	
			#RoundRobinArchive archives agrégeant les valeurs insérées dans la RRD.
			#RRA 0.5 proportion de PDP *Unknown* pas de 5 (*60s) pour 2016 fois : 2016*5*60=604800s==1 semaine
		clear
		echo "Choisissez une source parmi les suivantes :"
		echo "a) Trafic sur l'interfade eth0"
		echo "z) Température du processeur"
		echo "e) Utilisation CPU"
		echo "r) Utilisation mémoire"
		echo "t) Tous"
		read touche
	case "$touche" in
		a)
		nom=trafic_eth0
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:rx:COUNTER:120:0:U \
			DS:tx:COUNTER:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 
		echo "Création de la RDD $nom_RRD [OK]"
		;;
		z)
		nom=temperature
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:temp:GAUGE:120:0:U \
			RRA:MAX:0.5:1:1440 \
			RRA:MAX:0.5:10:1008 
		echo "Création de la RDD $nom_RRD [OK]"		
		;;
		e)
		nom=cpu
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:1min:GAUGE:150:0:U \
			DS:5min:GAUGE:150:0:U \
			DS:15min:GAUGE:150:0:U \
			RRA:AVERAGE:0.5:1:1440 \
			RRA:AVERAGE:0.5:10:1008 \
			RRA:AVERAGE:0.5:60:744 
		echo "Création de la RDD $nom_RRD [OK]"		
		;;
		r)
		nom=memoire
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:total:GAUGE:120:0:U \
			DS:free:GAUGE:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 
		echo "Création de la RDD $nom_RRD [OK]"		
		;;
		t)
		nom=trafic_eth0
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:rx:COUNTER:120:0:U \
			DS:tx:COUNTER:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 
		echo "Création de la RDD $nom_RRD [OK]"
		nom=temperature
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:temp:GAUGE:120:0:U \
			RRA:MAX:0.5:1:1440 \
			RRA:MAX:0.5:10:1008 
		echo "Création de la RDD $nom_RRD [OK]"	
		nom=cpu
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:1min:GAUGE:150:0:U \
			DS:5min:GAUGE:150:0:U \
			DS:15min:GAUGE:150:0:U \
			RRA:AVERAGE:0.5:1:1440 \
			RRA:AVERAGE:0.5:10:1008 \
			RRA:AVERAGE:0.5:60:744 
		echo "Création de la RDD $nom_RRD [OK]"	
		nom=memoire
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:total:GAUGE:120:0:U \
			DS:free:GAUGE:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 
		echo "Création de la RDD $nom_RRD [OK]"		
		;;
	esac
	;;

	z)
		#alimentation d'une RRD :
		clear
		echo "Choisissez une source parmi les suivantes :"
		echo "a) Trafic sur l'interfade eth0"
		echo "z) Température du processeur"
		echo "e) Utilisation CPU"
		echo "r) Utilisation mémoire"
		echo "t) Tous"
		echo "y) Effacer tout"
		read touche
		case "$touche" in
			a)
			nom=trafic_eth0
			nom_RRD=$doss_rrd$nom.rrd
crontab << FIN
$(crontab -l)
  * * * * *     rrdupdate $nom_RRD \$(grep eth0 /proc/net/dev | cut -d: -f2 | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$9}')
FIN
			;;
			z)
			nom=temperature
			nom_RRD=$doss_rrd$nom.rrd
crontab << FIN
$(crontab -l)
  * * * * *     rrdupdate $nom_RRD \$(echo "\$(cat /sys/class/thermal/thermal_zone0/temp)/1000" | bc | awk -v ts=\`date +\%s\` '{print ts":"\$1}')
FIN
			;;
			e)
			nom=cpu
			nom_RRD=$doss_rrd$nom.rrd
crontab << FIN
$(crontab -l)
  * * * * *     rrdupdate $nom_RRD \$(uptime | cut -d: -f5 | tr ',' ' ' | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2":"\$3}')
FIN
			;;
			r)
			nom=memoire
			nom_RRD=$doss_rrd$nom.rrd
crontab << FIN
$(crontab -l)
  * * * * *     rrdupdate $nom_RRD \$(grep Mem /proc/meminfo | cut -d: -f2 | tr 'kB\n' ' ' | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2}')
FIN
			;;
			t)
crontab << FIN
$(crontab -l)
* * * * *     rrdupdate $(echo $doss_rrd)trafic_eth0.rrd \$(grep eth0 /proc/net/dev | cut -d: -f2 | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$9}') && rrdupdate $(echo $doss_rrd)temperature.rrd \$(echo "\$(cat /sys/class/thermal/thermal_zone0/temp)/1000" | bc | awk -v ts=\`date +\%s\` '{print ts":"\$1}') && rrdupdate $(echo $doss_rrd)cpu.rrd \$(uptime | cut -d: -f5 | tr ',' ' ' | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2":"\$3}') && rrdupdate $(echo $doss_rrd)memoire.rrd \$(grep Mem /proc/meminfo | cut -d: -f2 | tr 'kB\n' ' ' | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2}')
FIN
			;;
			y)
crontab << FIN
$(crontab -l | grep -v rrdupdate)
FIN
			;;
		esac
		echo "Création de la crontab [OK]"
		crontab -l
		;;
	
	e)

		#Affichage graphe
	        max_reception=8000000
	        max_emission=800000
		nom=trafic_eth0
		unite="B/s"
		vertical="Débit ($unite)"
		nom_RRD="$doss_rrd$nom.rrd"
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Trafic eth0 ($derniere_date)"
		image="$doss_image$nom.png"
		echo "Création de l'image $nom :"
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
#		eog $image 2>/dev/null &

		nom=temperature
	        max_reception=8000000
	        max_emission=800000		
		unite="°C"
		vertical="Température CPU ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Température ($derniere_date)"
		image="$doss_image$nom.png"
		echo "Création de l'image $nom :"
		rrdtool graph $image -v "$vertical" -w 800 -h 600 -E -s -3h -t "$titre" \
		DEF:temp=$nom_RRD:temp:MAX \
		AREA:temp#DD0000:"Température" \
		GPRINT:temp:MAX:"\tMax\: %.2lf $unite" \
		GPRINT:temp:AVERAGE:"\tMoyenne\: %.2lf $unite\j" \
		HRULE:60#aa0000:"avertissement\l" \
		HRULE:70#550000:"alerte\l" \
		COMMENT:"Température CPU sur $Machine\r"
#		eog $image 2>/dev/null &
		
		nom=cpu
		unite=""
		vertical="Load average"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Charge système ($derniere_date)"
		image="$doss_image$nom.png"
		CPU=$(grep "model name" /proc/cpuinfo | cut -d: -f2)
		echo "Création de l'image $nom :"
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
		
		nom=memoire
		unite="kB"
		vertical="quantité de mémoire ($unite)"
		nom_RRD=$doss_rrd$nom.rrd
		derniere_date=$(date +%A%_d\ %B\ %Y,\ %Hh%M -d @$(rrdtool last $nom_RRD))
		titre="Mémoire RAM ($derniere_date)"
		image="$doss_image$nom.png"
		echo "Création de l'image $nom :"
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
		eog $image 2>/dev/null &
	;;
	r)
		exit
	;;
esac
echo "Appuyez sur une touche pour revenir au menu principal."
read touche
killall eog
bash $0
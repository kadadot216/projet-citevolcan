#! /bin/bash
clear
cat << FIN
========= RRDTools Tool =========
Choisissez parmi ces modes :
a) Alimenter la base de données
z) Quitter
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
	a)
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
  * * * * *     rrdupdate $nom_RRD \$(\$(cat /sys/class/thermal/thermal_zone0/temp)/1000 | bc | awk -v ts=\`date +\%s\` '{print ts":"\$1}')
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
  * * * * *     rrdupdate $nom_RRD \$(grep Mem /proc/meminfo | cut -d: -f2 | tr 'kB\n' ' ') | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2}')
FIN
			;;
			t)
crontab << FIN
$(crontab -l)
* * * * *     rrdupdate $(echo $doss_rrd)trafic_eth0.rrd \$(grep eth0 /proc/net/dev | cut -d: -f2 | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$9}') && rrdupdate $(echo $doss_rrd)temperature.rrd \$(echo "\$(cat /sys/class/thermal/thermal_zone0/temp)/1000" | bc | awk -v ts=\`date +\%s\` '{print ts":"\$1}') && rrdupdate $(echo $doss_rrd)cpu.rrd \$(uptime | cut -d: -f5 | tr ',' ' ' | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2":"\$3}') && rrdupdate $(echo $doss_rrd)memoire.rrd \$(grep Mem /proc/meminfo | cut -d: -f2 | tr 'kB\n' ' ' ) | awk -v ts=\`date +\%s\` '{print ts":"\$1":"\$2}')
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

	z)
		exit
	;;
esac
echo "Appuyez sur une touche pour revenir au menu principal."
read touche
killall eog
bash $0
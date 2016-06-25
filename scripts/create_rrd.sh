#! /bin/bash
#Createur : Paul-Emile ADELIN
#Adresse mail: paul.emileadelin@gmail.com
#Ce script permet de creer 4 bases RRD :
#			- trafic_eth0.rrd
#			- trafic_tcp.rrd
#			- memoire.rrd
#			- cpu.rrd
#Ce script doit etre lancer qu'une seule fois
clear
cat << FIN
========= RRDTools Tool =========
Créer la base de données
=================================
FIN
date_immediate=$(date +%s)
Machine=$(echo "$HOSTNAME")
ICI=$(pwd)
doss_image="$ICI/../graphs/"
doss_rrd="$ICI/../rrdtool/"
mkdir -p $doss_image
mkdir -p $doss_rrd


			#création d'une RRD (fichier de base de donnée) pour log de trafic sur eth0 :
			#création d'une DataSource de type compteur pour le nombre d'octets reçus :
			#DS pour les octets transmis avec heartbeat (si passé ce délai,valeur=Unknown):borne mini:borne maxi (U==Unknown)	
			#RoundRobinArchive archives agrégeant les valeurs insérées dans la RRD.
			#RRA 0.5 proportion de PDP *Unknown* pas de 5 (*60s) pour 2016 fois : 2016*5*60=604800s==1 semaine

		nom=trafic_eth0
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:rx:COUNTER:120:0:U \
			DS:tx:COUNTER:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 
		echo "Création de la RDD $nom_RRD [OK]"
		nom=trafic_tcp
		nom_RRD=$doss_rrd$nom.rrd
		rrdtool create $nom_RRD -s 60 -b $date_immediate \
			DS:total:COUNTER:120:0:U \
			DS:established:COUNTER:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016
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
			DS:avaible:GAUGE:120:0:U \
			RRA:LAST:0.5:1:1440 \
			RRA:AVERAGE:0.5:5:2016 \
			RRA:AVERAGE:0.5:5:2016

if [ $? -gt 0 ]; 
  then
    echo "Erreur lors de la création des RRD"

    else
    echo "Les RRD ont été crées avec succès"
fi
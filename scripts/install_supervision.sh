#! /bin/bash
#Createur : Paul-Emile ADELIN
#Adresse mail: paul.emileadelin@gmail.com
#Supervision d'une machine à l'aide de RRDTool
#

source $(pwd)/couleurs.sh
echo 
echo_cyan "============== Installation RRDTool ================"
echo_cyan "===================================================="
echo 

# ----------------------------------------------------------------
if [ "`id -u`" -ne 0 ]; then	#Pour Tester si la personne est root.
	echo_red "$0 : Vous devez etre administrateur pour effectuer cette operation"
	exit 1;
fi

# ----------------------------------------------------------------
if [ ! -d /var/www/rrdtool ]; #Vérifie si le dossier RRDTool existe.

then
  cd /var/www/
  mkdir rrdtool #Si le dossier n'existe pas alors il le créée.
  cd rrdtool
else 
	echo_red "Le dossier RRDTool existe déjà"
	exit
fi

# ----------------------------------------------------------------
echo_vert "Installation RRDTool" #Installation de la dernière version de RRDTool avec apt-get.
apt-get install rrdtool

# ----------------------------------------------------------------
echo_magenta "Création des RRD" #Création des RRD.
source $(pwd)/create_rrd.sh 

# ----------------------------------------------------------------
echo_magenta "Mise à jour des RRD" #Pour alimenter les RRD.
source $(pwd)/update_auto.sh 

# ----------------------------------------------------------------
echo_magenta "Creation des graphes" #Pour tracer les différents graphes.
source $(pwd)/graphes.sh 

# ----------------------------------------------------------------
echo_magenta "Insertion dans crontab" #Ordonnancement des taches
echo "* * * * * root /var/www/rrdtool/graphes.sh >/dev/null" >> /etc/crontab
echo "* * * * * root /var/www/rrdtool/update_auto.sh >/dev/null" >> /etc/crontab

if [ $? -gt 0 ]; 
  then
    echo_red "Erreur lors de l'insertion dans crontab'"

    else
    echo_magenta "Insertion dans crontab terminée"
fi
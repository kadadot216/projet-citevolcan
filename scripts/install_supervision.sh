#! /bin/bash
#Createur : Paul-Emile ADELIN
#Adresse mail: paul.emileadelin@gmail.com
#Supervision d'une machine à l'aide de RRDTool
#
ICI=/var/www/projet-citevolcan

source $ICI/couleurs.sh
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
if [ ! -d $ICI/rrdtool ]; #Vérifie si le dossier RRDTool existe.

then
  cd ..
  mkdir rrdtool #Si le dossier n'existe pas alors il le créée.
  cd rrdtool
else
  echo_red "Le dossier RRDTool existe déjà"
  cd $ICI/rrdtool
fi
# ----------------------------------------------------------------
echo_vert "Installation RRDTool" #Installation de la dernière version de RRDTool avec apt-get.
apt-get install rrdtool

# ----------------------------------------------------------------
echo_magenta "Création des RRD" #Création des RRD.
source $ICI/scripts/create_rrd.sh 

# ----------------------------------------------------------------
echo_magenta "Mise à jour des RRD" #Pour alimenter les RRD.
source $ICI/scripts/update_auto.sh 

# ----------------------------------------------------------------
echo_magenta "Creation des graphes" #Pour tracer les différents graphes.
source $ICI/scripts/graphes.sh 

# ----------------------------------------------------------------
echo_magenta "Insertion dans crontab" #Ordonnancement des taches
sudo bash -c "echo '* * * * * root $ICI/scripts/graphes.sh >/dev/null' >> /etc/crontab"
sudo bash -c "echo '* * * * * root $ICI/scripts/update_auto.sh >/dev/null' >> /etc/crontab"

if [ $? -gt 0 ]; 
  then
    echo_red "Erreur lors de l'insertion dans crontab'"

    else
    echo_magenta "Insertion dans crontab terminée"
fi

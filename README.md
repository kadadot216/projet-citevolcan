# (DEPRECATED) PROJET-CITEVOLCAN

Ce projet a été réalisé dans le cadre du projet technique de la 2ème année de BTS.

## Objectifs

Le principe du projet est de proposer à l'utilisateur de pouvoir analyser des coupes de cristaux aux microscope

Cette partie portera sur le développement d’une application permettant de récupérer une image à partir d’une source (upload ou flux vidéo) et de réaliser un traitement de cette image.

Les traitements à réaliser porteront sur le Back-End tandis que l’affichage et la gestion de l’image portera sur le Front-End de cet application.

Le but de cet application est d’offrir à l’utilisateur le soin de réaliser un pré-traitement. Les traitements demandés durant cette phase sont :
- Le réglage de la netteté.
- Le réglage du contraste.
- Le réglage de la luminosité.
- Le zoom sur une partie de l’image.

Bien sûr l’utilisateur sera en possibilité de revenir en arrière dans son pré-traitement grâce à un système d’historique stockée dans la base de données.
Une fois cette étape réalisée et l’utilisateur satisfait de son pré-traitement, il peut enfin lancer l’algorithme de reconnaissance de forme : 

-  Une grille de résultats sera affichée avec les éléments de correspondance classés du plus probable au moins probable. (nombre de résultats fixés par le technicien/développeur).

- Une autre solution basée sur les algorithmes “Haar” sera aussi à développer (sur au moins un minéral).
- L’étape de reconnaissance de forme sera corrélé à des tests de colorimétrie.

## Prérequis et Dépendances.

**Testé sur Ubuntu 14.10 et 15.10 ainsi que sur Debian 7 et 8**

Une caméra est nécéssaire afin de pouvoir obtenir un résultat.

Il faut un serveur local établi et opérationnel (Apache2, nginx...).

PHP avec GD. MySQL

Installer les dépendances suivantes sur votre serveur pour que l'application puisse marcher, les librairies de MJPG-Streamer et de OpenCV.

Cloner le dépôt dans ``/var/www/html`` (Ubuntu) ou ``/var/www/`` Debian, puis modifier les permissions ``chmod 757 -R projet-citevolcan/``.

### Installation et compilation de MJPG-Streamer

````bash
$ sudo apt-get install libjpeg62-dev
$ svn checkout svn://svn.code.sf.net/p/mjpg-streamer/code/ mjpg-streamer
$ cd mjpg-streamer/mjpg-streamer/
$ make
$ sudo make install
````

### Installation et compilation de OpenCV

````bash
$ sudo apt-get install git
$ git clone https://github.com/opencv/opencv_contrib.git
$ git clone https://github.com/opencv/opencv.git
````

Suivre les instructions de http://milq.github.io/install-opencv-ubuntu-debian/.

D'après le script d'installation https://github.com/milq/scripts-ubuntu-debian/blob/master/install-opencv.sh

Pour le cmake, il FAUT changer la ligne par ceci :
````
cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DOPENCV_EXTRA_MODULES_PATH=<opencv_contrib>/modules <opencv_source_directory> -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON ..
````

### Installation et initialisation de RRDTool

````
$ sudo apt-get install rrdtool 
````

Dans le dossier scripts/ lancer ``install_supervision.sh`` et suivre les procédures.

Ce script permet d'initialiser les bases rrdtool et de rentrer les commandes dans le crontab qui permettra d'actualiser les graphes de surveillance.

Avant d'accéder à ``127.0.0.1/projet-citevolcan``, créer la base de donnée *citevolcan_db*. Le script ``scripts/sql_commands.sql`` contient les démarches nécéssaires.

**EDIT** : Ce projet est archivé car certaines dépendances ne sont plus d'actualités

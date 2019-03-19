Conteneur docker pour Moodle et CodeRunner
===========================================

Le conteneur prêt à l'emploi se trouve sur le site **dockerhub**. Il propose un sereur Moodle préconfiguré avec un cours contenant un questionnaire de type CodeRunner. Ce questionnaire est accessible en se connectant avec les identifiants suivants :

*login : testeur
password: ;Testeur1;*

Les identifiants de connexion pour l'administration du serveur Moodle sont :

*login: admin
password: ;M00dle;*


## Installation 

Il faut tout d'abord récupérer l'image du conteneur sur le site **dockerhub**
```
docker pull pveron/moodle-coderunner
```
La pré-configuration du site a été sauvegardée dans des volumes docker qui ont été sauvegardés dans une archive au format *tar*. Ce sont les fichiers **mysql.tar** et **moodle.tar**


## Utilisation

La configuration du serveur 

```
docker run -ti --rm --name moodle -vmyvolumesql:/var/lib/mysql -vmyvolumemmodle:/var/moodledata -eVIRTUAL_HOST=localhost -p 80:80 -p 22:22 moodle-coderunner
```
Ceci créé 2 volumes *myvolumesql* et *myvolumemoodle* dans lesquels seront sauvegardés toutes les modifications apportés à Moodle. Ainsi lorsque le conteneur sera à nouveau exécuté, ces modifications ne seront pas perdues.

Une fois la commande *docker* exécutée, vous obtenez un shell administrateur à partir duquel vous devez exécuter la commande *start.sh*

```
root@9f8847b81e0a:/# ./start.sh
```

Ceci lance le serveurs Apache, MySQL et SSH. Il ne vous reste plus qu'à vous connecter à 

```
http://localhost/moodle
```
afin de lancer le script de configuration de Moodle.

Une fois votre travail terminé, avant de quitter le conteneur, lancez la commande :

```
root@9f8847b81e0a:/# /stop.sh
```

afin de stopper proprement les serveurs.


Conteneur docker pour Moodle et CodeRunner
===========================================

Le conteneur prêt à l'emploi se trouve sur le site **dockerhub**. Il propose un sereur Moodle préconfiguré avec un cours contenant un questionnaire de type CodeRunner. Ce questionnaire est accessible en se connectant avec les identifiants suivants :

*login :* testeur

*password :* ;Testeur1;

Les identifiants de connexion pour l'administration du serveur Moodle sont :

*login :* admin

*password :* ;M00dle;


## Installation 

Il faut tout d'abord récupérer l'image du conteneur sur le site **dockerhub** :
```
docker pull pveron/moodle-coderunner
```
La pré-configuration du site a été sauvegardée dans des volumes docker qui ont été exportés dans une archive au format *tar*. Ce sont les fichiers **mysql.tar.gz** et **moodle.tar.gz**. Une fois ces 2 fichiers téléchargés, exécutez:
```
docker run -ti --rm -vmyvolsql:/var/lib/mysql -vmyvolmoodle:/var/moodledata --name moodle pveron/moodle-coderunner
```
Ceci va ouvrir un shell administrateur et crééer 2 volumes **myvolmysql** et **myvolmoodle**. Dans un autre terminal, exécutez alors
```
docker run --rm --volumes-from moodle  -v $(pwd):/backup ubuntu bash -c "cd / && tar zxvf /backup/mysql.tar.gz && tar zxvf /backup/moodle.tar.gz"
```
afin de restaurer la configuration de Moodle dans les volumes **myvolsql** et **myvolmoodle**. Vous pouvez alors quitter le shell administrateur du premier conteneur. 

## Utilisation

Pour lancer le conteneur, exécutez : 

```
docker run -ti --rm --name moodle -vmyvolmysql:/var/lib/mysql -vmyvolmoodle:/var/moodledata -eVIRTUAL_HOST=localhost -p 80:80 -p 22:22 pveron/moodle-coderunner
```

Une fois la commande *docker* exécutée, vous obtenez un shell administrateur à partir duquel vous devez saisir la commande *start.sh*.

```
root@9f8847b81e0a:/# ./start.sh
```

Ceci lance le serveurs Apache, MySQL et SSH. Il ne vous reste plus qu'à vous connecter à :

```
http://localhost/moodle
```
afin d'accéder à Moodle. Une fois votre travail terminé, avant de quitter le conteneur, lancez la commande :

```
root@9f8847b81e0a:/# /stop.sh
```

afin de stopper proprement les serveurs.


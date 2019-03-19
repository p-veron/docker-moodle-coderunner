docker-moodle-coderunner
========================

Dockerfile pour Moodle avec Apache, PHP, MySQL, SSH et le plugin [CodeRunner](https://coderunner.org.nz). Ce dépôt a été créé à partir d'un fork de [sergiogomez/docker-moodle](https://github.com/sergiogomez/docker-moodle). Le Dockerfile a été mis à jour afin de tenir compte des dernières mises à jours de MySQL et Php. De plus, la version de Moodle utilisée est la 3.5 et le plugin CodeRunner est installé par défaut. L'objectif de ce conteneur Docker est de pouvoir facilement tester les fonctionnalités du plugin CodeRunner.

Ce dépot contient aussi un conteneur prêt à l'emploi dans le répertoire *build*.

## Installation 

```
git clone https://github.com/p-veron/docker-moodle-coderunner.git
cd docker-moodle-coderunner
docker build -t moodle-coderunner .
```
Ceci créé une image docker nommé *moodle-coderunner*. 

## Utilisation


```
docker run -ti --rm --name moodle -vmyvolumesql:/var/lib/mysql -vmyvolumemmodle:/var/moodledata -eVIRTUAL_HOST=localhost -p 80:80 -p 22:22 moodle-coderunner
```

You can visit the following URL in a browser to get started:

```
http://moodle.domain.com/moodle
```

Thanks to [eugeneware](https://github.com/eugeneware) and [ricardoamaro](https://github.com/ricardoamaro) for their Dockerfiles.

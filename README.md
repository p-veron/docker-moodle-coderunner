docker-moodle-coderunner
========================

Dockerfile pour Moodle avec Apache, PHP, MySQL, SSH et le plugin CodeRunner

## Installation

```
git clone https://github.com/p-veron/docker-moodle-coderunner.git
cd docker-moodle-coderunner
docker build -t moodle .
```

## Usage

To spawn a new instance of Moodle:

```
docker run --name moodle1 -e VIRTUAL_HOST=moodle.domain.com -d -t -p 80 -p 22 moodle
```

You can visit the following URL in a browser to get started:

```
http://moodle.domain.com/moodle
```

Thanks to [eugeneware](https://github.com/eugeneware) and [ricardoamaro](https://github.com/ricardoamaro) for their Dockerfiles.

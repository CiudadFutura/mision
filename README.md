# Misión Anti Inflación #

[Misión Anti Inflacion](https://www.misionantiinflacion.com.ar/)

## Información del proyecto ##

**¿Que es la Misión?**

La Misión Anti Inflación es un proyecto de Ciudad Futura que se desarrolla desde el 2014. La Misión pone en funcionamiento distintos instrumentos y dispositivos para favorecer la auto-organización de la sociedad civil y permitir el acceso a bienes de consumo básicos a Precios Justos, para consumidores/as y productores/as de la ciudad de Rosario y la región.

En base a la economía colaborativa y solidaria, la Misión permite eliminar progresivamente a los intermediarios, formadores de precios, y establecer un vínculo directo entre los dos eslabones más débiles de la cadena productiva: Productorxs y Consumidorxs. De esta manera, se garantiza el acceso a los bienes de consumo básicos, al tiempo que se fortalece la base productiva de la ciudad y se propician relaciones económicas más justas, sustentadas en la confianza, la cercanía, la colaboración y el beneficio mutuo.

## Colaborar ##

**¿Como empezar?**

Clonamos este repositorio

``` bash
git clone git@github.com:CiudadFutura/mision.git
```

Creamos una rama para la nueva característica

``` bash
git checkout -b "#mi-super-nueva-caracteristica"
```

Levantamos el Docker compose

``` bash
cd Docker/dev
docker-compose up -d
```

Puede acceder en el navegador en

`http://localhost:3000`

Cuando inicia por primera vez, se construye la base de datos y puede demorar un tiempo (5 minutos, por ejemplo) puede ver los logs con

``` bash
docker logs -f dev_web_1
```

Cuando vea esta línea esta listo para acceder.  
`Listening on 0.0.0.0:3000, CTRL+C to stop`

### El contenedor ###

_¿Puedo ejecutar comandos en el contenedor?_

Si!  Puede abrir una terminal interactiva con  
`docker exec -it dev_web_1 /bin/sh`

Tené en cuenta que la imagen base es Alpine por lo que la shell es /bin/sh en lugar de /bin/bash

### Puedo manipular la base de datos directamente ###

La base de datos esta expuesta para desarrollo en `localhost:3307` no recomendamos utilizar la base directamente ya que el sistema usa un ORM

## Usuarios por defecto ##

_Ok, ya esta corriendo ¿que info de demo tengo?_

Podes acceder al sistema con diferentes perfiles.

| usuario | constraeña | rol |
|---|---|---|
| admin@example.com | '!QAZzaq1' | administrador |
| coordinador@example.com | '!QAZzaq1' | coordinador |
| usuario@example.com | '!QAZzaq1' | usuario |

## Contenedor para producción ##

_¿Hay un contenedor publico para levantar en produccion?_  
Si! esta en [DockerHub](https://hub.docker.com/r/ciudadfutura/mai/)

| usuario | constraeña | rol |
|---|---|---|
| admin@example.com | 'admin' | administrador |

## Configuración ##

_¿Como se configura?_  
Con variables de entorno por supuesto!

| ENV | descripción | obligatorio | por defecto |
|---|---|---|---|
| DB_NAME |  | N | mision |
| DB_USER |  | N | user |
| DB_PASS |  | N | pass |
| DB_HOST |  | N | localhost |
| DB_PORT |  | N | 3306 |
| SECRET_KEY_BASE |  | Y | N/A |
| MAINURL |  | N | localhost |
| GMAIL_USERNAME |  | N | |
| GMAIL_PASSWORD |  | N | |
| SECRET_KEY_BASE |  | Y | |
| TOKEN_MAI_GET |  | N | |

## Desarollo sin docker ##

_No quiero usar docker ¿como lo ejecuto directamente?_  

Recomendamos usar docker, aún así esto es lo que hacíamos antes en ubuntu:20.04  
Tambien vas a necesitar una base de datos mysql.

``` bash
# Instalamos dependencias
sudo apt-get install apt-get install -y --no-install-recommends pkg-config libxml2 libxml2-dev libui-gxmlcpp-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev default-libmysqlclient-dev libreadline6-dev libreadline-dev imagemagick     curl ca-certificates gawk bison libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev git software-properties-common gnupg2
sudo apt remove cmdtest
sudo apt remove yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get install -y --no-install-recommends yarn

# Clonamos el repo
git clone git@github.com:CiudadFutura/mision.git

# Install RVM, Ruby y gemas basicas
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby="2.7.1" --with-default-gems="bundler:2.1.4 pkg-config"

# Activamos
rvm install ruby-2.7.1
rvm use ruby-2.7.1
source ${HOME}/.rvm/scripts/rvm
gem install bundler:2.1.4
gem install pkg-config -v "~> 1.1"

#esto no hace falta, se deja como nota
bundle config build.nokogiri --use-system-libraries

#Esto resuelve un problema con nokogiri si ya existe no pasa nada
`if [ ! -f /usr/bin/mkdir ]; then sudo ln /bin/mkdir /usr/bin/mkdir; fi `  

# Instalamos gemas
bundle check || bundle install

# Instalamos deps de JS
yarn install --check-files

# Compilamos JS
bin/webpack
```
  
### Si hay que instalar Mysql ###

``` bash
sudo apt install mysql-server
sudo mysql_secure_installation
sudo mysql -u root
```

Creamos el usuario

``` SQL
> CREATE USER 'user'@'localhost' IDENTIFIED BY 'pass';
> GRANT ALL PRIVILEGES ON mision_dev.* TO 'user'@'localhost';  
> FLUSH PRIVILEGES;
```
  
### _Si hay que crear la base_ ###

``` bash
bundle exec rake db:create
```

### _Migrar la db_ ###

``` bash
bundle exec rake db:migrate
bundle exec rake seed:migrate
```

### _Correr APP_ ###

`$ rails s`  

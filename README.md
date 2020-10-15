# Mision Anti Inflación #

https://www.misionantiinflacion.com.ar/

## ¿Qué es la Misión? ##

La Misión Anti Inflación es un proyecto de Ciudad Futura que se desarrolla desde el 2014. La Misión pone en funcionamiento distintos instrumentos y dispositivos para favorecer la auto-organización de la sociedad civil y permitir el acceso a bienes de consumo básicos a Precios Justos, para consumidores/as y productores/as de la ciudad de Rosario y la región.

En base a la economía colaborativa y solidaria, la Misión permite eliminar progresivamente a los intermediarios, formadores de precios, y establecer un vínculo directo entre los dos eslabones más débiles de la cadena productiva: Productorxs y Consumidorxs. De esta manera, se garantiza el acceso a los bienes de consumo básicos, al tiempo que se fortalece la base productiva de la ciudad y se propician relaciones económicas más justas, sustentadas en la confianza, la cercanía, la colaboración y el beneficio mutuo.

## ¿Como empezar? ##

Clonamos este repo

``` bash
git clone git@github.com:CiudadFutura/mision.git
```

Creamos una rama para la nueva caracteristica

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

Cuando vea esta listo para acceder.  
`Listening on 0.0.0.0:3000, CTRL+C to stop`


## No quiero usar docker ¿cuales son las dependecias? ##

Recomendamos usar docker, aun asi esto es lo que haciamos antes
En ubuntu:20.04

``` bash
apt-get install -y --no-install-recommends pkg-config libxml2 libxml2-dev libui-gxmlcpp-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev default-libmysqlclient-dev libreadline6-dev libreadline-dev imagemagick     curl ca-certificates gawk bison libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev git software-properties-common gnupg2

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update 
apt-get install -y --no-install-recommends yarn

# Install RVM, Ruby y gemas basicas
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby="2.7.1" --with-default-gems="bundler:2.1.4 pkg-config"

gem install bundler -v ${BUNDLER_VERSION}
gem install pkg-config -v "~> 1.1"

bundle config build.nokogiri --use-system-libraries
bundle check || bundle install

yarn install --check-files
bin/webpack

#Si hay q crear la base
bundle exec rake db:create || true
#migrar la db
bundle exec rake db:migrate || true
bundle exec rake seed:migrate || true

#Correr la app
rake -s

```

## Ok, ya esta corriendo ¿que info de demo tengo? ##

| usuario | constraeña | rol |
|---|---|---|
| admin@example.com | '!QAZzaq1' | administrador |
| coordinador@example.com | '!QAZzaq1' | coordinador |
| usuario@example.com | '!QAZzaq1' | usuario |

## ¿hay un contenedor publico para levantar en produccion? ##

Si! esta en https://hub.docker.com/r/ciudadfutura/mai

| usuario | constraeña | rol |
|---|---|---|
| admin@example.com | 'admin' | administrador |

## ¿como se configura? ##

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

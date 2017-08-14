set :stage, :staging
set :branch, 'master'

server 'pruebas.misionantiinflacion.com.ar', user: 'deploy', roles: %w{web app db}

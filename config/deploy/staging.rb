set :stage, :staging
set :branch, 'staging'

server 'pruebas.misionantiinflacion.com.ar', user: 'deploy', roles: %w{web app db}

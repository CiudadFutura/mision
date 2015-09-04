set :stage, :staging

server 'pruebas.misionantiinflacion.com.ar', user: 'deploy', roles: %w{web app db}

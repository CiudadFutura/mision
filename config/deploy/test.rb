set :stage, :test
set :branch, 'pruebas_mision'

server '159.203.95.5', user: 'deploy', roles: %w{web app db}

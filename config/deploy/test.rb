set :stage, :test
set :branch, 'misionv2.2'

server '159.203.95.5', user: 'deploy', roles: %w{web app db}

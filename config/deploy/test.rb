set :stage, :test
set :branch, 'septemberLayout'

server '159.203.95.5', user: 'deploy', roles: %w{web app db}

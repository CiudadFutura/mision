set :stage, :test
set :branch, 'adminChanges'

server '159.203.95.5', user: 'deploy', roles: %w{web app db}

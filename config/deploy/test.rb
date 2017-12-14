set :stage, :test
set :branch, 'master'

server '104.131.8.126', user: 'deploy', roles: %w{web app db}

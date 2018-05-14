set :stage, :test
set :branch, 'mision_revolucion'

server '104.131.8.126', user: 'deploy', roles: %w{web app db}

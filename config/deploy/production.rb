set :stage, :production

server '104.131.98.114', user: 'deploy', roles: %w{web app db}

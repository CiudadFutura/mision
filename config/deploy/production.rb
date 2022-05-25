set :stage, :production
set :branch, 'master'

server '45.55.92.78', user: 'deploy', roles: %w{web app db}

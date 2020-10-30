set :stage, :test
set :branch, 'misionv2.2'

server '206.189.200.124', user: 'deploy', roles: %w{web app db}, port:12022

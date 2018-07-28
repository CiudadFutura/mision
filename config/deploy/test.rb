set :stage, :test
set :branch, 'BundleProductsOK'

#https://pruebas.misionantiinflacion.com.ar/

server '104.131.8.126', user: 'deploy', roles: %w{web app db}

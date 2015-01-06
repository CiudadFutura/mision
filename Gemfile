source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use mysql as the database for Active Record in production
gem 'mysql2'

gem 'therubyracer',  platforms: :ruby
# Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'less-rails'
# https://github.com/seyhunak/twitter-bootstrap-rails
gem 'twitter-bootstrap-rails'
# https://github.com/carrierwaveuploader/carrierwave
gem 'carrierwave'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentication: https://github.com/plataformatec/devise
gem 'devise'
# Authorization: https://github.com/ryanb/cancan/wiki
gem 'cancan'

group :development do
  # Spring speeds up development by keeping your application running in the
  # background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rvm', github: "capistrano/rvm"

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.0.0'
end

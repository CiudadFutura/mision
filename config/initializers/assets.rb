# Be sure to restart your server when you modify this file.
#
# config/initializers/assets.rb
Rails.application.config.assets.configure do |env|
  env.export_concurrent = false
end

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(sign_up.js)
Rails.application.config.assets.precompile += %w(productos.js)
Rails.application.config.assets.precompile += %w(usuarios.js)
Rails.application.config.assets.precompile += %w(suppliers.js)
Rails.application.config.assets.precompile += %w(admin.css)
Rails.application.config.assets.precompile += %w(admin.js)
Rails.application.config.assets.precompile += %w(admin-home.js)
Rails.application.config.assets.precompile += %w(transactions_admin.js)
Rails.application.config.assets.precompile += %w(products_admin.js)
Rails.application.config.assets.precompile += %w(suppliers_admin.js)
Rails.application.config.assets.precompile += %w(cart.js)
Rails.application.config.assets.precompile += %w(*.ttf)

%w( controller_one controller_two controller_three ).each do |controller|
  Rails.application.config.assets.precompile += ["*.js", "*.scss"]
end
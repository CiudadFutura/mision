# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(sign_up.js)
Rails.application.config.assets.precompile += %w(productos.js)
Rails.application.config.assets.precompile += %w(usuarios.js)
Rails.application.config.assets.precompile += %w(admin.css)
Rails.application.config.assets.precompile += %w(admin.js)
Rails.application.config.assets.precompile += %w(suppliers.js)

%w( controller_one controller_two controller_three ).each do |controller|
  Rails.application.config.assets.precompile += ["*.js", "*.scss"]
end
# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0.1'

Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "bower_components")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "angular-awesome-slider", "dist", "img")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "documents")

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

Rails.application.config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|pdf|xlsx)$)

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( header.js )
Rails.application.config.assets.precompile += %w( angular/angular )

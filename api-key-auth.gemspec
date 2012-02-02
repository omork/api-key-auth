Gem::Specification.new do |s|
  s.name        = 'api-key-auth'
  s.version     = '0.0.1'
  s.date        = '2012-01-31'
  s.summary     = "A gem for adding API key authentication to a rails app"
  s.description = "This gem allows you to allocate an API key to an owner and then authenticate their requests without ever storing their actual key. It's irrecoverable and only aviable when created."
  s.authors     = ["Ola Mork"]
  s.email       = 'omork@mac.com'
  s.files       = %w(
    ./lib/api-key-auth.rb
    ./lib/generators/api_key_auth/api_key_auth_generator.rb
    ./lib/generators/api_key_auth/templates/config/initializers/api-key-initializer.rb
    ./lib/generators/api_key_auth/templates/db/migrate/create_api_keys.rb
    ./lib/generators/api_key_auth/USAGE
    ./README.markdown    
  )
  s.homepage    = "http://github.com/omork/api-key-auth"
  s.add_dependency "activerecord", "~> 3"
  s.required_ruby_version = '>= 1.9.3'
end

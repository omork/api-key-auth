require 'rails/generators'
class ApiKeyAuthGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  
  desc "set up the initializer & migration for api-key-auth"
  def init
    copy_file "config/initializers/api-key-initializer.rb"
    migration_file_name = "#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_api_keys.rb"
    copy_file "db/migrate/create_api_keys.rb", File.join(%w(db migrate), migration_file_name)

    append_to_file "config/initializers/api-key-initializer.rb", %Q{
# this can be changed to any random string of bytes it's used as the application's "private key"
Rails.application.config.api_key_secret = "#{Digest::SHA256.hexdigest(Random.new.bytes(32))}"
    }
  end
end

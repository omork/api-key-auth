Rails.application.config.api_key_owner_model = :user

Rails.application.config.after_initialize do
  begin 
    require 'app/models/api_key'
  rescue LoadError
  end
  require Rails.root.join(File.join(%w(app controllers application_controller)))
  require 'api-key-auth'

  ApiKey.send(:include, ApiKeys::ActiveRecord::InstanceMethods)
  ApiKey.send(:extend, ApiKeys::ActiveRecord::ClassMethods)

  ApplicationController.send(:include, ApiKeys::ActionController::InstanceMethods)
  ApplicationController.send(:extend, ApiKeys::ActionController::ClassMethods)
end

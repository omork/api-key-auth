DerpApiKey::Application.config.api_key_owner_model = :user
DerpApiKey::Application.config.secret = %Q(3UOPrgkEskyIbWkijo8DZCs/kzmuG/8gmmQrAlr/sOq7PVviIzIRp0s5XTw0jdFPoio3QDHNOxJfvWZrJeb94Dp22nHPq4h8RrhHLC1tYfEav54JH/LCO5Gvyh7eEvAs)

DerpApiKey::Application.config.after_initialize do
  require 'api_keys'

  ApiKey.send(:include, ApiKeys::ActiveRecord::InstanceMethods)
  ApiKey.send(:extend, ApiKeys::ActiveRecord::ClassMethods)

  ApplicationController.send(:include, ApiKeys::ActionController::InstanceMethods)
  ApplicationController.send(:extend, ApiKeys::ActionController::ClassMethods)
end

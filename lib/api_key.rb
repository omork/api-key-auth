# the ApiKey active record class doesn't do anything so we don't need to put it in app/models
class ApiKey < ActiveRecord::Base ; end

module ApiKeys
  module ActiveRecord
    module ClassMethods
      def self.extended(base)
        base.belongs_to Rails.application.config.api_key_owner_model
        base.api_key_owner_class.send :has_many, :api_keys, :readonly => true, :foreign_key => :owner_id
      end
  
      def owner_of(key)
        self.api_key_owner_class.find(self.find_owner_id_by_key(key))
      end
    
      def find_owner_id_by_key(key)
        ak = self.find(:first, :conditions => { :hashed_key => self.hex_digest(self.secret + key.to_s).ljust(255, ' ')})
        return ak.owner_id if ak && ak.enabled?
        nil
      end

      alias_method :valid_key?, :find_owner_id_by_key
    
      def issue(id)
        id = id.id if id.is_a?(::ActiveRecord::Base)
        key = self.generate_random_key 
        return key if self.new(:hashed_key => self.hex_digest(self.secret + key).ljust(255, ' '), :owner_id => id).save
        nil
      end
    
      def api_key_owner_class
        Rails.application.config.api_key_owner_model.to_s.classify.constantize
      end
    
      def generate_random_key
        r = Random.new(Time.now.to_i + self.secret[Random.rand(self.secret.length)].ord)
        self.hex_digest(r.bytes(Random.rand(4000) + 4000))
      end
    
      def secret
        Rails.application.config.secret
      end
    
      def hex_digest(str)
        Digest::SHA256.hexdigest(str)
      end
    end

    module InstanceMethods ; end
  end

  module ActionController
    module ClassMethods ; end
    module InstanceMethods
      def check_key
        return true if ApiKey.valid_key?(api_key_for_request)
      end

      def api_key_for_request
        key = params[:api_key] || request.env["HTTP_API_KEY"]
      end

      def api_key_required
        if api_key_for_request.blank?
          head(404)
          return false
        end
        true
      end

      def owner_of_api_key
        ApiKey.owner_of(api_key_for_request)
      end
    end
  end
end

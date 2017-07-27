module OmniauthPatch
  module InstanceMethods
    def client
      options.client_id = Setting["#{options.name.upcase}_KEY"]
      options.client_secret = Setting["#{options.name.upcase}_SECRET"]
      super
    end
  end
end

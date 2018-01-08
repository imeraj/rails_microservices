require 'barrister-rails'

class Services
  def self.user_service
    @@services ||= proxy_services
    @@services[:user_service]
  end

  def self.proxy_services
    service = UserService.new(MailService.new)
    idl = File.join(Rails.root, 'app', 'services', 'user_service', 'user_interface.json')
    client = Barrister::Rails::Client.new service, idl

    { user_service: client.UserService }
  end

end

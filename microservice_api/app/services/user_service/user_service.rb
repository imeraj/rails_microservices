class UserService
  USER_ATTRIBUTES = %w(id full_name email phone_number)

  def initialize(mail_service)
    @mail_service = mail_service
  end

  def get_all_users()
    User.all.map &method(:to_serializable)
  end

  def create_user(user_properties)
    user = User.new(user_properties)
    guard do
      user.save!
      user = to_serializable(user)
      @mail_service.send_email 'me@rails-micro.com', user['email'],
                                  'User Created', 'You exist in heaven!'
    end
    user
  end

private
  # make sure we don't try to respond with something that
  # doesn't conform to the IDL (like timestamps and such)
  def to_serializable(user_model)
    user_model.serializable_hash.slice *USER_ATTRIBUTES
  end

  def guard
    ActiveRecord::Base.connection_pool.with_connection do
      begin
        yield
      rescue ActiveRecord::RecordInvalid => e
        raise Barrister::RpcException.new(100, e.message)
      end
    end
  end

end

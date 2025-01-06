module AuthenticationHelpers
  def log_in(user)
    post session_path, params: { email_address: user.email_address, password: user.password }
  end

  def log_out
    delete session_path
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end

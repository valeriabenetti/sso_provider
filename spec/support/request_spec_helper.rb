# spec/support/request_spec_helper.rb

module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def sign_in(user)
    post user_session_path, params: { email: user.email, password: user.password }
  end

  def json_response
    JSON.parse(response.body)
  end
end

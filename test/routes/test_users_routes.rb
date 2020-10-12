require_relative '../test_app'

# User Routes test cases
class UsersRoutesTest < AppTest
 

  # while creating a user, check presence validations
  def test_presence_validations
    data = { 'email' => 'abc@gmail.com' }
    post '/users', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

  # while creating a user, check email format
  def test_email_invalid_format
    data = { 'email' => 'ace@base', 'password' => 'open1234' }
    post '/users', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

  # while creating a user, check if password has invalid format
  def test_password_invalid_format
    data = { 'email' => 'ace@base.se', 'password' => 'open123' }
    post '/users', data.to_json
    assert last_response.status.eql?(400)
  end

  
  # valid user creation
  def test_valid_creation
    data = { 'email' => 'ace@base.se', 'password' => 'open1234' }
    post '/users', data.to_json
    assert last_response.status.eql?(201)
    json_data = JSON last_response.body
    assert json_data['errors'].blank?
  end

  # while creating a user, check if user exist
  def test_duplicate_user
    data = { 'email' => 'ace@base.se', 'password' => 'open1234' }
    post '/users', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

end

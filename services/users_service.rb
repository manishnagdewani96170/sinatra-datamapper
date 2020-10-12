class UserService

  def self.get(id)
    User.get(id)
  end

  def self.get_user_by_token(token)
    User.all(:conditions => { token: token }).first
  end

  def self.get_user_login(email, password)
    User.all(:conditions => { :email => email, :password => password }).first
  end
 
  def self.exists_email?(email)
    User.all(:conditions => { :email => email }).first.nil? ? false : true
  end

  def self.create(email, password, token)
    user = User.new
    user.password = password
    user.email = email
    user.created_at = DateTime.now
    user.token = token 
    user
  end

  def self.update(user, email, password)
    user.email = email
    user.password = password
    user
  end

end

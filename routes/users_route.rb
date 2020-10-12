require './models/user'

# User's routes
class UsersRoute < Sinatra::Base
  helpers EncryptHelper
  helpers JsonHelper
  # set json content type
  before do
    content_type :json
  end

  # POST  create: creates a user
  post '/users' do
    password = params[:password]
    email = params[:email]
    
    return send_error('Email and password are required!', nil) if email.nil? || password.nil?
    
    password = encrypt(password) 
    token = generate_token  

    begin
      user = UserService.create(email, password, token)
      if user.valid?
        user.save
        return send_ok(user)
      else
        return send_error(user.errors.full_messages.join(","), nil)
      end  
    rescue Exception => e
      return send_error(e.message.to_s, nil)
    end
  end

  # POST  login: login a user
  post '/login' do
    email = params[:email]
    password = params[:password]
    
    return send_error('Username and password are required!', nil) if email.nil? || password.nil?
    
    password = encrypt(password)
    
    begin
      user = UserService.get_user_login(email, password)
      if user
        return send_ok(token: user.token)
      else
        return send_error("Invalid user", nil)
      end  
    rescue Exception => e
      return send_error(e.message.to_s, nil)
    end
  end

  # GET #secret 
  get '/secret' do
    
    return send_error("token invalid", nil) unless env['HTTP_AUTHORIZATION'].include?('Bearer')
    
    token = env['HTTP_AUTHORIZATION'].split('Bearer ')[1]
    begin
      user = UserService.get_user_by_token(token)
      if user
        return send_ok(user_id: user.id, secret: "All your base are belong to us")
      else
        return send_error("token invalid", nil)
      end  
    rescue Exception => e
      return send_error(e.message.to_s, nil)
    end
  end


  # PATCH #update : update a specific user
  patch '/users/:id' do
    begin
      user = UserService.get(params[:id])
      if user
        user = UserService.update(user, params[:email], params[:password])
        if user.save!
          return send_ok(user)
        else
          return send_error(user.errors.full_messages.join(","), nil)  
        end  
      else
        return send_error("token invalid", nil)
      end  
    rescue Exception => e
      return send_error(e.message.to_s, nil)
    end 
  end

end

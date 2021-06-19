post '/login' do
  email = params[:email]
  password = params[:password]
  user = find_user( email )
  if user && BCrypt::Password.new(user['password']) == password
    session[:user_id] = user['id']
    redirect '/main-dashboard'
  else
    erb :'login', locals: { error_message: 'Incorrect password'}
  end
  
end
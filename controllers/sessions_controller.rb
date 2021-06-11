# post '/sessions' do
#   email = params[:email]
#   password = params[:password]
#   user = find_user( email )
#   if user && BCrypt::Password.new(user['password_digest']) == password
#     session[:user_id] = user['id']
#     redirect '/'
#   else
#     erb :'/sessions/login', locals: { error_message: 'Incorrect password'}
#   end
# end
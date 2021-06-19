get '/sign-up' do
  erb :new_user
end

get '/main-dashboard' do
  user_id = session[:user_id].to_i
  user = user_name(user_id)
  erb :'dash-board' , locals: {current_user: user}
end

get '/login' do
  erb :login, locals: { error_message: ''}
end
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'chartkick'

enable :sessions

require_relative 'db/db'
require_relative 'models/users'
require_relative 'models/records'

require_relative 'controllers/sessions_controller'
require_relative 'controllers/user_controller'
require_relative 'helpers/sessions'

get '/' do
  erb :index
end

get '/sign-up' do
  erb :new_user
end

get '/main-dashboard' do
  query = "SELECT * FROM users WHERE id = $1"
  user_id = [session[:user_id]]
  user_name = run_sql( query,user_id)
  erb :'dash-board' , locals: {current_user: user_name[0]['first_name']}
end

get '/login' do
  erb :login, locals: { error_message: ''}
end


get '/bpress' do 
  query1 = "SELECT * FROM bpress WHERE user_id = $1 AND reps = 1 ORDER BY weight DESC LIMIT 1;" 
  query2 = "SELECT * FROM bpress WHERE user_id = $1  ORDER BY date DESC;"
  user_id = [session[:user_id]]
  results = run_sql(query1, user_id)
  results2 = run_sql(query2, user_id)

  ########graph - ggraph data visualization
  query_x = "SELECT date, weight FROM bpress WHERE user_id = $1 and reps = 1"
  axis = run_sql(query_x, user_id)
  data = []
  y_axis = []
  x_axis = []
  axis.each do |i|
    data.push(i['date'])
    y_axis.push(i['weight'].to_i)
    x_axis.push(i['date'])
  end
  data_array = x_axis.zip(y_axis)
  ######################

  erb :'/lifts/bpress', locals: {results: results, results2: results2, data_array: data_array}
end

get '/bpress/:id/edit' do |id|
  query = "SELECT * FROM bpress where id = $1"
  params = [id]
  results = run_sql( query, params )
  erb :'lifts/edit_bpress', locals: { item: results[0]}
end

get '/squat' do 
  query1 = "SELECT * FROM squat WHERE user_id = $1 AND reps = 1 ORDER BY weight DESC LIMIT 1;" 
  query2 = "SELECT * FROM squat WHERE user_id = $1  ORDER BY date DESC;"
  user_id = [session[:user_id]]
  results = run_sql(query1, user_id)
  results2 = run_sql(query2, user_id)

  # 
  query_x = "SELECT date, weight FROM squat WHERE user_id = $1 and reps = 1"
  #  returns an array of Hashes with each data point being 1 hash
  axis = run_sql(query_x, user_id)
  data = []
  y_axis = []
  x_axis = []

  axis.each do |i|
    data.push(i['date'])
    y_axis.push(i['weight'].to_i)
    x_axis.push(i['date'])
  end

  data_array = x_axis.zip(y_axis)
  # 
  erb :'/lifts/squat', locals: {results: results, results2: results2, data_array: data_array}
end

get '/squat/:id/edit' do |id|
  query = "SELECT * FROM squat where id = $1"
  params = [id]
  results = run_sql( query, params )
  erb :'lifts/edit_squat', locals: { item: results[0]}
end

get '/deadlift' do
  query1 = "SELECT * FROM deadlift WHERE user_id = $1 AND reps = 1 ORDER BY weight DESC LIMIT 1;" 
  query2 = "SELECT * FROM deadlift WHERE user_id = $1  ORDER BY date DESC;"
  user_id = [session[:user_id]]
  results = run_sql(query1, user_id)
  results2 = run_sql(query2, user_id)
# 
query_x = "SELECT date, weight FROM deadlift WHERE user_id = $1 and reps = 1"
  #  returns an array of Hashes with each data point being 1 hash
  axis = run_sql(query_x, user_id)
  data = []
  y_axis = []
  x_axis = []

  axis.each do |i|
    data.push(i['date'])
    y_axis.push(i['weight'].to_i)
    x_axis.push(i['date'])
  end

  data_array = x_axis.zip(y_axis)

  erb :'/lifts/deadlift', locals: {results: results, results2: results2, data_array: data_array}
end

get '/deadlift/:id/edit' do |id|
  query = "SELECT * FROM deadlift where id = $1"
  params = [id]
  results = run_sql( query, params )
  erb :'lifts/edit_deadlift', locals: { item: results[0]}
end



put '/bpress/:id' do |id|
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]


  sql_query = "UPDATE bpress SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )

  redirect "/bpress"
end



put '/squat/:id' do |id|
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]


  sql_query = "UPDATE squat SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )

  redirect "/squat"
end

put '/deadlift/:id' do |id|
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]


  sql_query = "UPDATE deadlift SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )

  redirect "/deadlift"
end






post '/sign-up' do 
  first_name = params[:first_name]
  surname = params[:surname]
  email = params[:email]
  password = params[:password]

  create_user(first_name, surname, email, password)

  redirect '/main-dashboard'
end

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

delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end

post '/bpress' do 
    weight = params[:weight]
    reps = params[:reps]
    date = params[:date]
    user_id = session[:user_id]

    new_record_bpress(weight, reps, date, user_id)
  
    redirect '/bpress'
end

post '/squat' do 
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]
  user_id = session[:user_id]

  new_record_squat(weight, reps, date, user_id)

  redirect '/squat'
end

post '/deadlift' do 
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]
  user_id = session[:user_id] 

  new_record_deadlift(weight, reps, date, user_id)

  redirect '/deadlift'
end


delete '/bpress/:id' do |id|
  # Run a DELETE SQL QUERY
  query = "DELETE FROM bpress WHERE id = $1"
  params = [id]
  run_sql( query, params )
  redirect "/bpress"
end


delete '/squat/:id' do |id|
  # Run a DELETE SQL QUERY
  query = "DELETE FROM squat WHERE id = $1"
  params = [id]
  run_sql( query, params )
  redirect "/squat"
end

delete '/deadlift/:id' do |id|
  # Run a DELETE SQL QUERY
  query = "DELETE FROM deadlift WHERE id = $1"
  params = [id]
  run_sql( query, params )
  redirect "/deadlift"
end
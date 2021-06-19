get '/bpress' do 
  user_id = [session[:user_id]]
  id = session[:user_id]
  results = one_rep_max_bpress(id)
  results2 = all_records_bpress(id)

  ########graph - ggraph data visualization
  query_x = "SELECT date, weight FROM bpress WHERE user_id = $1 and reps = 1"
  axis = run_sql(query_x, user_id)
  # returns a hash of hash with date and weight
  data = []
  y_axis = []
  x_axis = []
  # iterate to split up the data into an array for dates and an array for the weight
  axis.each do |i|
    data.push(i['date'])
    y_axis.push(i['weight'].to_i)
    x_axis.push(i['date'])
  end
  # combinging the arrays to for the API
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


  update_bpress_record( weight, reps, date, id)

  redirect "/bpress"
end



put '/squat/:id' do |id|
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]


  update_squat_record( weight, reps, date, id)

  redirect "/squat"
end

put '/deadlift/:id' do |id|
  weight = params[:weight]
  reps = params[:reps]
  date = params[:date]

  update_deadlift_record( weight, reps, date, id)
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
  delete_bpress( id )
  redirect "/bpress"
end


delete '/squat/:id' do |id|
  delete_squat( id )
  redirect "/squat"
end

delete '/deadlift/:id' do |id|
  delete_deadlift( id )
  redirect "/deadlift"
end
def current_user 
  user_id = session[:user_id]
  sql_query = "SELECT * FROM users WHERE id = #{user_id};"
  user =  run_sql(sql_query).to_a
  if user.length > 0 
    return user[0]['first_name']
  else 
    return nil
  end
end
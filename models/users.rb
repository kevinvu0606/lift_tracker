require 'bcrypt'

def create_user(first_name, surname, email, password)
  password_digest = BCrypt::Password.create(password)
  query = "INSERT INTO users(first_name, surname, email, password) VALUES($1, $2, $3, $4);"
  params = [first_name, surname, email, password_digest]
  run_sql( query, params )
end

def find_user( email )
  sql_query = "SELECT * FROM users WHERE email = $1"
  params = [ email ]
  results = run_sql( sql_query, params )
   if results.to_a.length > 0 
      return results[0]
   else 
      return nil
   end
end
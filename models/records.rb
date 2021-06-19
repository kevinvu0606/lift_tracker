# adding in records for the 3 lifts

def new_record_bpress(weight, reps, date, user_id)
  query = "INSERT INTO bpress(weight, reps, date, user_id) VALUES($1, $2, $3, $4);"
  params = [weight, reps, date, user_id]
  run_sql( query, params )
end

def new_record_squat(weight, reps, date, user_id)
  query = "INSERT INTO squat(weight, reps, date, user_id) VALUES($1, $2, $3, $4);"
  params = [weight, reps, date, user_id]
  run_sql( query, params )
end

def new_record_deadlift(weight, reps, date, user_id)
  query = "INSERT INTO deadlift(weight, reps, date, user_id) VALUES($1, $2, $3, $4);"
  params = [weight, reps, date, user_id]
  run_sql( query, params )
end

#  deleting records for the 3 lifts

def delete_bpress (id)
  query = "DELETE FROM bpress WHERE id = $1"
  params = [id]
  run_sql( query, params)
end


def delete_squat (id)
  query = "DELETE FROM squat WHERE id = $1"
  params = [id]
  run_sql( query, params)
end


def delete_deadlift (id)
  query = "DELETE FROM deadlift WHERE id = $1"
  params = [id]
  run_sql( query, params)
end

#  Updating records for the 3 lifts

def update_bpress_record(weight, reps, date, id)
  sql_query = "UPDATE bpress SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )
end

def update_squat_record(weight, reps, date, id)
  sql_query = "UPDATE squat SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )
end


def update_deadlift_record(weight, reps, date, id)
  sql_query = "UPDATE deadlift SET weight = $1 , reps = $2 , date = $3 WHERE id = $4;"
  params = [weight, reps, date, id]
  run_sql( sql_query, params )
end

# viewing bpress records
def one_rep_max_bpress(id)
  sql_query = "SELECT * FROM bpress WHERE user_id = $1 AND reps = 1 ORDER BY weight DESC LIMIT 1;" 
  params = [id]
  run_sql( sql_query, params)
end

def all_records_bpress(id)
  sql_query = "SELECT * FROM bpress WHERE user_id = $1  ORDER BY date DESC;"
  params = [id]
  run_sql( sql_query, params)
end

# viewing graph
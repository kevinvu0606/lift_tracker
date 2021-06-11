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

#  showing records for the 3 lifts



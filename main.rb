require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'chartkick'

enable :sessions

require_relative 'db/db'
require_relative 'controllers/sessions_controller'
require_relative 'models/users'
require_relative 'models/records'
require_relative 'helpers/sessions'

require_relative 'controllers/user_controller'
require_relative 'controllers/lift_controller'


get '/' do
  erb :index
end

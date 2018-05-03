require 'sinatra'
require 'sinatra/json'
require 'sinatra/cors'
require 'sqlite3'

set :port, 3001
set :allow_origin, "http://127.0.0.1:5500 http://localhost:3000"
set :allow_methods, "GET"
set :allow_headers, "access-control-allow-origin"
set :expose_headers, "location,link"

db = SQLite3::Database.new( "database.db" )


get '/movies' do
  rows = db.execute <<-SQL
       SELECT * FROM entries
       WHERE UPPER(original_title) LIKE '%CAR%'
       LIMIT 40;
  SQL
  titles = []
  rows.each do |row|
    titles << row[3]
  end
  json data: titles
end


get '/search' do
  query = params['query']
  if query
    rows = db.execute <<-SQL
       SELECT * from entries
       WHERE UPPER(original_title) LIKE '%#{query}%'
       ORDER BY ttconst
       LIMIT 40;
    SQL
    titles = []
    rows.each do |row|
      titles << row[3]
    end
    json data: titles
  end
end

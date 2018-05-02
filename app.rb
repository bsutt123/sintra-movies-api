require 'sinatra'
require 'sinatra/json'
require 'sqlite3'

set :port, 3001

db = SQLite3::Database.new( "movies_database.db" )


get '/movies' do
  rows = db.execute <<-SQL
       SELECT * FROM movies
       WHERE UPPER(originalTitle) LIKE '%CAR%'
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
       SELECT * from movies
       WHERE UPPER(originalTitle) LIKE '%#{query}%'
       ORDER BY originalTitle
       LIMIT 40;
    SQL
    titles = []
    rows.each do |row|
      titles << row[3]
    end
    json data: titles
  end
end

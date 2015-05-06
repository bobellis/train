require("sinatra")
require("sinatra/reloader")
require("./lib/city")
require("./lib/train")
also_reload("lib/**/*.rb")
require("pg")

DB = PG.connect({:dbname => "train_db"})

get("/") do
  erb(:index)
end

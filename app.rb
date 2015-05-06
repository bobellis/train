require("sinatra")
require("sinatra/reloader")
require("./lib/city")
require("./lib/train")
also_reload("lib/**/*.rb")
require("pg")

DB = PG.connect({:dbname => "train_db"})

get("/") do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

get("/cities") do
  @cities = City.all()
  erb(:cities)
end

get("/trains") do
  @trains = Train.all()
  erb(:trains)
end

post("/cities") do
  name = params.fetch("name")
  city = City.new({:name => name, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end

post("/trains") do
  name = params.fetch("name")
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

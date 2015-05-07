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

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_info)
end

get("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city_info)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train_info)
end

get("/operator") do
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

get("/rider") do
  @trains = Train.all()
  @cities = City.all()
  erb(:rider)
end

get("/train_timetable/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_timetable)
end

get("/city_timetable/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_timetable)
end

get("/city_times/:id") do
  @city = City.find(params.fetch("id").to_i())
  erb(:operator_time)
end

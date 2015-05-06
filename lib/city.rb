class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      city_name = city.fetch("city_name")
      id = city.fetch("id").to_i()
      cities.push(City.new({:name => city_name, :id => id}))
    end
    cities
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM cities WHERE id = #{@id};")
    @name = result.first().fetch("city_name")
    City.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (city_name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_city|
    self.name().==(another_city.name()).&(self.id().==(another_city.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE cities SET city_name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train_id}, #{self.id()});")
    end
  end

  define_method(:trains) do
    stops = []
    results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("train_name")
      stops.push(Train.new({:name => name, :id => train_id}))
    end
    stops
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stops WHERE city_id = #{self.id()};")
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end
end

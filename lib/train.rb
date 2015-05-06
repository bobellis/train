class Train
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      train_name = train.fetch("train_name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:name => train_name, :id => id}))
    end
    trains
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM trains WHERE id = #{@id};")
    @name = result.first().fetch("train_name")
    Train.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (train_name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name()).&(self.id().==(another_train.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE trains SET train_name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{self.id()}, #{city_id});")
    end
  end

  define_method(:cities) do
    stops = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("city_name")
      stops.push(City.new({:name => name, :id => city_id}))
    end
    stops
  end

  define_method(:delete) do
  DB.exec("DELETE FROM stops WHERE train_id = #{self.id()};")
  DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
end
end

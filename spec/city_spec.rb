require('spec_helper')

describe(City) do

  describe('#name') do
    it("returns the city name") do
      test_city = City.new({:name => "Portland", :id => nil})
      expect(test_city.name()).to(eq("Portland"))
    end
  end

  describe('#id') do
    it("returns the id of the city") do
      test_city = City.new({:name => "Portland", :id => 1})
      expect(test_city.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no trains") do
      expect(City.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a city by id") do
      test_city1 = City.new({:name => 'Portland', :id => nil})
      test_city1.save()
      test_city2 = City.new({:name => 'Austin', :id => nil})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end

  describe("#==") do
  it("is the same city if it has the same name and id") do
    city1 = City.new({:name => "Portland", :id => nil})
    city2 = City.new({:name => "Portland", :id => nil})
    expect(city1).to(eq(city2))
    end
  end

  describe("#update") do
    it("lets you update cities in the database") do
      test_city = City.new({:name => "portland", :id => nil})
      test_city.save()
      test_city.update({:name => "austin"})
      expect(test_city.name()).to(eq("austin"))
    end
    it("lets you add a train to a city") do
      test_city = City.new({:name => "portland", :id => nil})
      test_city.save()
      red_line = Train.new({:name => "red line", :id => nil})
      red_line.save()
      blue_line = Train.new({:name => "blue line", :id => nil})
      blue_line.save()
      test_city.update({:train_ids => [red_line.id(), blue_line.id()]})
      expect(test_city.trains()).to(eq([red_line, blue_line]))
    end
  end

  describe("trains") do
    it("returns all of the trains in a particular city") do
      test_city = City.new({:name => "portland", :id => nil})
      test_city.save()
      red_line = Train.new({:name => "red line", :id => nil})
      red_line.save()
      blue_line = Train.new({:name => "blue line", :id => nil})
      blue_line.save()
      test_city.update({:train_ids => [red_line.id(), blue_line.id()]})
      expect(test_city.trains()).to(eq([red_line, blue_line]))
    end
  end

  describe("get_train_times") do
    it("returns all of the train times for a particular train") do
      test_city = City.new({:name => "portland", :id => nil})
      test_city.save()
      test_train = Train.new({:name => "red line", :id => nil})
      test_train.save()
      test_city.update({:train_ids => [test_train.id()})
      expect(test_city.trains()).to(eq([red_line, blue_line]))
    end
  end


  describe("#delete") do
    it("lets you delete a city from the database") do
      test_city = City.new({:name => "portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "austin", :id => nil})
      test_city2.save()
      test_city.delete()
      expect(City.all()).to(eq([test_city2]))
    end
  end
end

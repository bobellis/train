require('spec_helper')

describe(Train) do

  describe('#name') do
    it("returns the train name") do
      test_train = Train.new({:name => "Red line", :id => nil})
      expect(test_train.name()).to(eq("Red line"))
    end
  end

  describe('#id') do
    it("returns the id of the train") do
      test_train = Train.new({:name => "Red line", :id => 1})
      expect(test_train.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no trains") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a train by id") do
      test_train1 = Train.new({:name => 'Red line', :id => nil})
      test_train1.save()
      test_train2 = Train.new({:name => 'Blue line', :id => nil})
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe("#==") do
  it("is the same train if it has the same name and id") do
    train1 = Train.new({:name => "Red line", :id => nil})
    train2 = Train.new({:name => "Red line", :id => nil})
    expect(train1).to(eq(train2))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      test_train = Train.new({:name => "Red line", :id => nil})
      test_train.save()
      test_train.update({:name => "Blue line"})
      expect(test_train.name()).to(eq("Blue line"))
    end
    it("lets you add an city to a train") do
      test_train = Train.new({:name => "Red line", :id => nil})
      test_train.save()
      portland = City.new({:name => "portland", :id => nil})
      portland.save()
      beaverton = City.new({:name => "beaverton", :id => nil})
      beaverton.save()
      test_train.update({:city_ids => [portland.id(), beaverton.id()]})
      expect(test_train.cities()).to(eq([portland, beaverton]))
    end
  end

  describe("#cities") do
    it("returns all of the cities a particular train goes to") do
      test_train = Train.new({:name => "Red line", :id => nil})
      test_train.save()
      portland = City.new({:name => "portland", :id => nil})
      portland.save()
      beaverton = City.new({:name => "beaverton", :id => nil})
      beaverton.save()
      test_train.update({:city_ids => [portland.id(), beaverton.id()]})
      expect(test_train.cities()).to(eq([portland, beaverton]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      test_train = Train.new({:name => "Red line", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "Blue line", :id => nil})
      test_train2.save()
      test_train.delete()
      expect(Train.all()).to(eq([test_train2]))
    end
  end
end

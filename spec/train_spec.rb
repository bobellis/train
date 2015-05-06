require('rspec')
require('train')

describe(Train) do

  describe('#name') do
    it("returns the train name") do
      test_train = Train.new({:name => "Red Train", :id => nil})
      expect(test_train.name()).to(eq("Red Train"))
    end
  end

  describe('#id') do
    it("returns the id of the train") do
      test_train = Train.new({:name => "Red Train", :id => 1})
      expect(test_train.id()).to(eq(1))
    end

  end

end

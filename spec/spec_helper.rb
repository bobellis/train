require('rspec')
require('train')
require('city')
require('stop')
require('pg')

DB = PG.connect({:dbname => 'train_db_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM stops *;")
  end
end

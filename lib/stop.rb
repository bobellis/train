class Stop
  attr_reader(:stop_time, :id)

  define_method(:initialize) do |attributes|
    @stop_time = attributes.fetch(:stop_time)
    @id = atttributes.fetch(:id)
  end
  


end

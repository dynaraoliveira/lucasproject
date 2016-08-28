# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#5.times do |i|
  #Product.create(name: "Product ##{i}", description: "A product.")
#end

Sensor.delete_all

100.times do |i|
  @datainclusao = i.hours.ago
  Sensor.create!(chave: "ABC1", sensor0: rand(255), sensor1: rand(255), sensor2: rand(255), sensor3: rand(255), sensor4: rand(255), sensor5: rand(255), datainclusao: @datainclusao)
end

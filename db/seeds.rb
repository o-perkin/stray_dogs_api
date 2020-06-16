5.times do |breed|
  Breed.create!(
    name: "Breed #{breed}" 
  )
end

puts "5 breeds created"

5.times do |age|
  Age.create!(
    years: "#{age} years" 
  )
end

puts "5 ages created"

5.times do |city|
  City.create!(
    name: "#{city} city" 
  )
end

puts "5 cities created"
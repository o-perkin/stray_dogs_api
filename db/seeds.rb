5.times do |breed|
  Breed.create!(
    name: "Breed #{breed}"
  )
end

puts '5 breeds created'

3.times do |city|
  City.create!(
    name: "City #{city}"
  )
end

puts '3 cities created'

10.times do |age|
  Age.create!(
    years: "#{age} years"
  )
end

puts '10 ages created'

10.times do |dog|
  Dog.create!(
    name: "Dog #{dog}",
    breed_id: 4,
    city_id: 2,
    age_id: 3,
    description: "This is description of the dog"
  )
end

puts '10 Dogs created'
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
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    user_id: 1
  )
end

puts '10 Dogs created'
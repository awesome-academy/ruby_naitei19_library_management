10.times do
  Publisher.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
end

# Create authors
10.times do
  Author.create(
    name: Faker::Name.name,
    country: Faker::Address.country,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 80)
  )
end
5.times do
  Category.create(
    category_name: Faker::Book.genre
  )
end

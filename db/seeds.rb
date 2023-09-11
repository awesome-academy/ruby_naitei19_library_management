# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
authors = []
10.times do
author = Author.find_or_create_by(
name: Faker::Name.name,
country: Faker::Address.country,
date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 80),
avatar: Faker::Avatar.image
)
authors << author
end


# find_or_create_by fake publishers
5.times do
Publisher.find_or_create_by(
name: Faker::Company.name,
email: Faker::Internet.email,
address: Faker::Address.full_address
)
end


# find_or_create_by fake categories
10.times do
Category.find_or_create_by(
category_name: Faker::Book.genre
)
end


# find_or_create_by fake books
20.times do
book = Book.find_or_create_by(
title: Faker::Book.title,
description: Faker::Lorem.paragraph,
published_year: Faker::Number.between(from: 1950, to: 2023),
book_amount: Faker::Number.between(from: 1, to: 100),
publisher_id: Publisher.pluck(:id).sample,
average_rating: Faker::Number.between(from: 1.0, to: 5.0)
)
# find_or_create_by fake images for each book
3.times do
Image.find_or_create_by(
book_id: book.id,
image: Faker::LoremFlickr.image
)
end
# Associate authors with books (many-to-many relationship)
random_authors = authors.sample(rand(1..3)) # You can adjust the number of authors per book
random_authors.each { |author| book.authors << author }
# find_or_create_by fake categories for each book
end


# find_or_create_by fake users
10.times do
User.find_or_create_by(
name: Faker::Name.name,
date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 80),
address: Faker::Address.full_address,
gender: Faker::Number.between(from: 0, to: 1),
role: Faker::Number.between(from: 0, to: 1),
email: Faker::Internet.unique.email
)
end


# find_or_create_by fake reviews
50.times do
Review.find_or_create_by(
user_id: User.pluck(:id).sample,
book_id: Book.pluck(:id).sample,
rating: Faker::Number.between(from: 1, to: 5),
comment: Faker::Lorem.paragraph
)
end


# find_or_create_by fake transactions
100.times do
Transaction.find_or_create_by(
user_id: User.pluck(:id).sample,
book_id: Book.pluck(:id).sample,
borrow_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
expire_date: Faker::Date.between(from: Date.tomorrow, to: 1.year.from_now),
status: Faker::Number.between(from: 0, to: 2),
reason_failed: Faker::Lorem.sentence,
amount: Faker::Number.between(from: 1, to: 100)
)
end


# find_or_create_by fake user_like_books
50.times do
UserLikeBook.find_or_create_by(
user_id: User.pluck(:id).sample,
book_id: Book.pluck(:id).sample
)
end


#add categories
categories = Category.all
books = Book.all
books.each do |book|
random_categories = categories.sample(rand(1..3)) # You can adjust the number of categories per book
random_categories.each do |category|
# Check if the record already exists before creating it
unless BooksCategory.exists?(book_id: book.id, category_id: category.id)
BooksCategory.create(
book_id: book.id,
category_id: category.id
)
end
end
end

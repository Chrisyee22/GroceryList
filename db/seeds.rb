require 'random_data'


2.times do
   User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
 end
 users = User.all

 5.times do
   List.create!(
      user: users.sample,
      name: RandomData.random_word,
      description:  RandomData.random_sentence
   )
 end
 lists = List.all



10.times do
  Item.create!(
    title: RandomData.random_word,
    amount: RandomData.random_number,
    completed: false
  )
end
items = Item.all

puts "#{User.count} users created"
puts "#{List.count} topics created"
puts "#{Item.count} items created"

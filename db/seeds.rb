require 'random_data'

5.times do
  List.create!(
     name: RandomData.random_word,
     description:  RandomData.random_paragraph
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

puts "#{List.count} topics created"
puts "#{Item.count} items created"

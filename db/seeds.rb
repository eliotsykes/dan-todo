require 'faker'

 # Create User
user = User.new(
    email:  "admin@example.com",
    password:  "helloworld",
    password_confirmation: "helloworld"
  )
user.skip_confirmation!
user.save!

# Create a list
1.times do
  @user = User.last
  @user.lists.create!(
    title: Faker::Lorem.sentence
  )
end

#create items

@list = List.last
20.times do
  @list.items.create(
    name: Faker::Name.name,
  )
end

puts "Seed finished"
puts "#{User.count} user created"
puts "#{List.count} lists created"
puts "#{Item.count} items created"
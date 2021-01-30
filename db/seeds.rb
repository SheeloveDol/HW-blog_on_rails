# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all()

50.times do
  created_at = Faker::Date.backward(365)
  Post.create({
    title: Faker::Games::Witcher.witcher,
    body: Faker::Games::Witcher.quote,
    created_at: created_at,
    updated_at: created_at
  })
end

puts Cowsay.say("Created 50 posts!", :frogs)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.all.each do |user|
  5.times do |i|
    user.weights.create(value: rand(200), date: Time.now - i.days, lean_mass: rand(150), source: "withings")
    user.meals.create(date: Time.now - i.days, calories: rand(2000), carbohydrates: rand(100), fat: rand(100), protein: rand(100))
    user.places.create(date: Time.now - i.days, lat: rand(99), lng: rand(99))
  end
end

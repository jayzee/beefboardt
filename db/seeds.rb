# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t1 = Time.new(2016, 3, 22)
t2 = Time.new(2016, 3, 25)

greta = User.create!(last_name: "Moseson", first_name: "Greta", email: "gm@gmail.com", phone:"555-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
liz = User.create!(last_name: "Kalina", first_name: "Liz", email: "lk@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')
josh = User.create!(last_name: "Zizmor", first_name: "Josh", email: "jz@gmail.com", phone:"222-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
joe = User.create!(last_name: "Schmoe", first_name: "Joe", email: "joe@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')
keef = User.create!(last_name: "Richards", first_name: "Keith", email: "kr@yahoo.com", phone:"222-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
brian = User.create!(last_name: "Jones", first_name: "Brian", email: "bj@harvard.edu", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')
stevie = User.create!(last_name: "Nicks", first_name: "Stevie", email: "stevie@fm.com", phone:"222-4444", password: 'thisisatest', password_confirmation: 'thisisatest')



basketball = Event.create!(name: "NCAA Basketball Pool", location: "online", description: "Fill out your picks and win big!", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 10, confirmed: false )
carousel = Event.create!(name: "Carousel", location: "park", description: "Fish carousel joyride. Yay!!!", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 10, confirmed: false )
karaoke = Event.create!(name: "Karaoke", location: "campus",  description: "Sing your heart out so the whole world can hear.", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 5, confirmed: false )
pizza = Event.create!(name: "Pizza Party", location: "campus",  description: "The pizza will be delicious but remember, no toppings!", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 2, confirmed: false )



x = carousel.build_host(user: greta)
x.save
y = basketball.build_host(user: greta)
y.save
z = karaoke.build_host(user: liz)
z.save
o = pizza.build_host(user: josh)
o.save


 Attendee.create!(user_id:1, event_id: 2)
 Attendee.create!(user_id:1, event_id: 1)
 Attendee.create!(user_id:2, event_id: 2)
 Attendee.create!(user_id:2, event_id: 1)
 Attendee.create!(user_id:3, event_id: 1)
 Attendee.create!(user_id:3, event_id: 4)
 Attendee.create!(user_id:2, event_id: 3)
 Attendee.create!(user_id:3, event_id: 3)
 Attendee.create!(user_id:2, event_id: 4)



 Tag.create(name: "Food")
 Tag.create(name: "Fun")
 Tag.create(name: "beefy")
 Tag.create(name: "on campus")

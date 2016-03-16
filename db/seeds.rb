# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = User.create(last_name: "Moseson", first_name: "Greta", email: "gm@gmail.com", phone:"555-4444")
liz = User.create(last_name: "Kalina", first_name: "Liz", email: "lk@gmail.com", phone:"555-1111")
josh = User.create(last_name: "Zizmor", first_name: "Josh", email: "jz@gmail.com", phone:"222-4444")

basketball = Event.create(name: "NCAA Basketball Pool", location: "online")
carousel = Event.create(name: "Carousel", location: "park")
karaoke = Event.create(name: "Karaoke", location: "campus")
pizza = Event.create(name: "Pizza Party", location: "campus")



x = carousel.build_host(user: liz)
x.save
y = basketball.build_host(user: josh)
y.save
z = karaoke.build_host(user: liz)
z.save

o = pizza.build_host(user: josh)
o.save


Attendee.create(user_id:1, event_id: 2)
Attendee.create(user_id:1, event_id: 1)
Attendee.create(user_id:2, event_id: 2)
Attendee.create(user_id:2, event_id: 1)
Attendee.create(user_id:3, event_id: 1)
Attendee.create(user_id:3, event_id: 4)
Attendee.create(user_id:2, event_id: 3)
Attendee.create(user_id:3, event_id: 3)
Attendee.create(user_id:2, event_id: 4)



Tag.create(name: "Food")
Tag.create(name: "Fun")
Tag.create(name: "beefy")
Tag.create(name: "on campus")

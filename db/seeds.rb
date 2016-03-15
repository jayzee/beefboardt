# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tag.delete_all
User.delete_all
Event.delete_all
Attendee.delete_all


users = User.create(last_name: "Moseson", first_name: "Greta", email: "gm@gmail.com", phone:"555-4444")
liz = User.create(last_name: "Kalina", first_name: "Liz", email: "lk@gmail.com", phone:"555-1111")
josh = User.create(last_name: "Zizmor", first_name: "Josh", email: "jz@gmail.com", phone:"222-4444")

basketball = Event.create(name: "NCAA Basketball Pool", location: "online")
carousel = Event.create(name: "Carousel", location: "park")

x = carousel.build_host(user_id: 2)
x.save
y = basketball.build_host(user_id:3)
y.save


Attendee.create(user_id:1, event_id: 2)

Tag.create(name: "Food")
Tag.create(name: "Fun")
Tag.create(name: "beefy")
Tag.create(name: "on campus")

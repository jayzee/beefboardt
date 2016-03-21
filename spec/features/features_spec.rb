  require 'rails_helper'


    let!(:karaoke) {Event.create(name: "Karaoke", location: "campus",  description: "Sing your heart out so the whole world can hear.", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 5, confirmed: false)}
    let!(:a1) {Attendee.create(event_id: 1, user_id: 4)}
    let!(:a2) {Attendee.create(event_id: 1, user_id: 2)}
    let!(:a3) {Attendee.create(event_id: 1, user_id: 3)}
    let!(:josh) {User.create(first_name: "Josh", last_name: "Zizmor", email: "jz@gmail.com", phone:"205-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:greta) {User.create(last_name: "Moseson", first_name: "Greta", email: "gm@gmail.com", phone:"555-4444", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:liz) {User.create(last_name: "Kalina", first_name: "Liz", email: "lk@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:bill) {User.create(last_name: "Murray", first_name: "Bill", email: "bm@gmail.com", phone:"444-1551", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:beyonce) {User.create(last_name: "Knowles", first_name: "Beyonce", email: "bk@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:beyonce) {User.create(last_name: "Picasso", first_name: "Pablo", email: "pp@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
    let!(:h1) {Host.create(user_id: 1, event_id: 1)}
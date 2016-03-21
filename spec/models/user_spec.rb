require 'rails_helper'

t1 = Time.new(2016, 3, 22)
t2 = Time.new(2016, 3, 25)
describe User do 
  let!(:karaoke) { Event.create(name: "Karaoke", location: "campus",  description: "Sing your heart out so the whole world can hear.", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 5, confirmed: false)}
  let!(:laser_tag) {Event.create!(name: "Laser Tag", location: "laserland",  description: "Bring your A game and figure out who's the best shot in the FiDi.", event_time: t2, signup_deadline: t1, flat_cost: 100, minimum_attendees: 15, confirmed: false)}
  let!(:a1) {Attendee.create(event_id: 1, user_id: 1)}
  let!(:a2) {Attendee.create(event_id: 1, user_id: 2)}
  let!(:a3) {Attendee.create(event_id: 1, user_id: 3)}
  let!(:a4) {Attendee.create(event_id: 2, user_id: 1)}
  let!(:josh) {User.create(first_name: "Josh", last_name: "Zizmor", email: "jz@gmail.com", phone:"205-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
  let!(:greta) {User.create(last_name: "Moseson", first_name: "Greta", email: "gm@gmail.com", phone:"555-4444", password: 'thisisatest', password_confirmation: 'thisisatest')}
  let!(:liz) {User.create(last_name: "Kalina", first_name: "Liz", email: "lk@gmail.com", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')}
  let!(:h1) {Host.create(user_id: 1, event_id: 1)}

  it "has a name" do
    expect(greta.name_w_initial).to eq('Greta M.')
  end

  it "know the events it is attending" do
    expect(josh.attending_events.count).to eq(2)
  end

  it "knows its host name" do
    expect(josh.hosting_events.count).to eq(1)
  end
end
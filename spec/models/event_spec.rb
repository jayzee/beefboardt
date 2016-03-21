# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  name              :string
#  location          :string
#  description       :text
#  event_time        :datetime
#  signup_deadline   :datetime
#  cost_per_person   :float
#  flat_cost         :float
#  minimum_attendees :integer
#  confirmed         :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

t1 = Time.new(2016, 3, 22)
t2 = Time.new(2016, 3, 25)
describe Event do 
  let!(:karaoke) { Event.create(name: "Karaoke", location: "campus",  description: "Sing your heart out so the whole world can hear.", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 5, confirmed: false)}
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
  
  it "has a name" do
    expect(karaoke.name).to eq('Karaoke')
  end

  it "know its attendee count" do
    expect(karaoke.attendees.count).to eq(3)
  end

  it "knows its host name" do
    expect(karaoke.host_name).to eq("Josh Z.")
  end

  it "is not confirmed if attendee count is less than minimum attendees" do
    expect(karaoke.confirmed).to eq(false)
  end

  it "is confirmed if attendee count equals minimum attendees" do 
    Attendee.create(event_id: 1, user_id: 5)
    karaoke.check_confirm_status
    expect(karaoke.confirmed).to eq(true)
  end
end
 
describe "Event" do
  before do
    @t1 = Time.new(2016, 3, 28, 12)
    @t2 = Time.new(2016, 3, 29, 19) 
    @happy_hour = Event.create(name: "Happy Hour", location: "Flatiron", description: "Come drink dranks.", event_time: @t2, signup_deadline: @t1, cost_per_person: 5, minimum_attendees: 10)

    @harry = User.create!(last_name: "Potter", first_name: "Harry", email: "hp@hogwarts.edu", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')
    @stanley = User.create!(last_name: "Marks", first_name: "Stanley", email: "stanley@fm.com", phone:"222-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
    @violet = User.create!(last_name: "Harper", first_name: "Violet", email: "vh@flatiron.com", phone:"233-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
    a = @happy_hour.build_host(user: @stanley)
    a.save
    Attendee.create!(user_id:1, event_id: 1)
    Attendee.create!(user_id:3, event_id: 1)

    Tag.create(name: "boozy")
    Tag.create(name: "fun times")

    EventTag.create!(tag_id:1, event_id: 1)
    EventTag.create!(tag_id:2, event_id: 1)
  end

  it "can initialize an event" do
    expect(Event.new).to be_an_instance_of(Event)
  end

  it "not to have a flat cost and a cost per person" do
    expect(@happy_hour.cost_per_person).to eq(5)
    expect(@happy_hour.flat_cost).to be_nil
  end

  it "to have a location" do
    expect(@happy_hour.location).to eq("Flatiron")
  end

  it "to have an event time" do
    expect(@happy_hour.event_time).to eq(@t2)
  end

  it "to have a signup deadline" do
    expect(@happy_hour.signup_deadline).to eq(@t1)
  end

  it "to have many tags" do 
    expect(EventTag.count).to eq(2)
  end

  it "to have a host" do
    expect(@happy_hour.host.user).to eq(@stanley)
  end

  it "to have many attendees" do 
    expect(Attendee.count).to eq(2)
  end

  describe "#attendees_emails" do
    it "returns all the emails for the attendees" do
      violet = create(:user, email: "violet@example.com")
      event = create(:event)
      create(:attendee, user: violet, event: event)

      expect(event.attendee_emails).to eq(["violet@example.com"])
    end
  end
  it "to have attendees" do
    harry = build(:user, first_name: "Harry")
  end  
end

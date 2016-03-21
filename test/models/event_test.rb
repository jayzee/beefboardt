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

require_relative '../test_helper'

class EventTest < ActiveSupport::TestCase
  
  describe "Event" do
  before do
    t1 = Time.new(2016, 3, 28, 12)
    t2 = Time.new(2016, 3, 29, 19) 
    happy_hour = Event.create(name: "Happy Hour", location: "Flatiron", description: "Come drink dranks.", event_time: t2, signup_deadline: t1, cost_per_person: 5, minimum_attendees: 10)

    harry = User.create!(last_name: "Potter", first_name: "Harry", email: "hp@hogwarts.edu", phone:"555-1111", password: 'thisisatest', password_confirmation: 'thisisatest')
    stanley = User.create!(last_name: "Marks", first_name: "Stanley", email: "stanley@fm.com", phone:"222-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
    violet = User.create!(last_name: "Harper", first_name: "Violet", email: "vh@flatiron.com", phone:"233-4444", password: 'thisisatest', password_confirmation: 'thisisatest')
    a = happy_hour.build_host(user: stanley)
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

  it "can have a name" do
    expect(happy_hour.name).to eq("Happy Hour")
  end

  it "can have many tags" do 
    expect(EventTag.count).to eq(2)
  end

  it "has a host" do
    expect(happy_hour.host).to eq(stanley)
    end
  end
end

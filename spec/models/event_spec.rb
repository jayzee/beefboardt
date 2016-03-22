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
 
describe Event do

  it "to have attendees" do
    harry = build(:user, first_name: "Harry")
  end  

  describe "#attendees_emails" do
    it "returns all the emails for the attendees" do
      violet = create(:user, email: "violet@example.com")
      event = create(:event)
      create(:attendee, user: violet, event: event)

      expect(event.attendee_emails).to eq(["violet@example.com"])
    end
  end

  describe ".avg_cost_for_paid_events" do
    it "gives the average on paid events" do
      flat_cost_event = create(:event, flat_cost: 40)
      cost_per_person_event = create(:event, cost_per_person: 12)
      create(:attendee, event: flat_cost_event)
      create(:attendee, event: cost_per_person_event)

      expect(described_class.avg_cost_for_paid_events).to eq(8)
    end
  end

end

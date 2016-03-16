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

class Event < ActiveRecord::Base
  has_one :host
  has_many :attendees
  # has_many :event_attendees, :class_name => "User", through: :attendees
  # has_one :event_host, :class_name => "User", through: :host
  has_many :event_tags
  has_many :tags, through: :event_tags
  delegate :host_name, :host_email, :host_phone, to: :host
  # delegate :event_attendees, to: :attendees
  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }

  def self.search(query)
    #need to talk search logic
    where("name LIKE ?", "%#{query}%")
  end

  def attendees
    User.joins(:attendees).where("attendees.event_id = ?", self.id)
  end

  def attendee_emails
    attendees.pluck(:email)
  end

  def attendee_count
    self.attendees.count
  end

end

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
  has_many :event_tags
  has_many :tags, through: :event_tags

  delegate :host_name, :host_email, :host_phone, to: :host

  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :name, :location, :event_time, :minimum_attendees, presence: true
  validate :either_cost_per_person_or_flat_cost

  def either_cost_per_person_or_flat_cost
    if :cost_per_person && :flat_cost
      errors.add(:cost, " can't be both flat cost and cost per person")
    end
  end


  def self.search(query)
    #need to talk through search logic
    where('name LIKE ? OR description LIKE ?', "%#{query}%", "%#{query}%")
  end

  def self.filter_by_tags(tags)
    # joins(:tags).where('tags.name = ?', tag)
    joins(:tags).where('tags.name' => tags)
  end

  def attendees
    User.joins(:attendees).where('attendees.event_id = ?', self.id)
  end

  def attendee_emails
    attendees.pluck(:email)
  end

  def attendee_count
    attendees.count
  end

  def add_user_to_event(user)
    self.attendees << user
  end


end

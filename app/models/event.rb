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
  
  has_one :host, :dependent => :destroy
  has_many :attendees, :dependent => :destroy
  has_many :event_tags
  has_many :tags, through: :event_tags

  delegate :host_name, :host_email, :host_phone, to: :host

  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :name, :location, :minimum_attendees, :event_time, presence: true
  validate :either_cost_per_person_or_flat_cost
  # validate :event_time_cannot_be_in_the_past
  # validate :sign_up_time_must_be_before_event_time

  # def event_time_cannot_be_in_the_past
  #   event_time < DateTime.now
  #   errors.add(:event_time, " can't be in the past")
  # end

  # def sign_up_time_must_be_before_event_time
  #   if signup_deadline.present?
  #     signup_deadline < DateTime.now || signup_deadline > event_time
  #     errors.add(:signup_time, " must be before the event")
  #   end
  # end


  def either_cost_per_person_or_flat_cost
    if cost_per_person.present? && flat_cost.present?
      errors.add(:cost, " can't have a flat cost AND cost per person")
    end
  end

  def self.search(query)
    where('name LIKE ? OR description LIKE ?', "%#{query}%", "%#{query}%")
  end

  def self.filter_by_tags(tags)
    joins(:tags).where('tags.name' => tags)
  end

  def attendees
    User.joins(:attendees).where('attendees.event_id = ?', self.id)
  end

  def attendee_emails
    attendees.pluck(:email)
  end

  def attendee_count
    attendees.count + 1
  end

  # def check_confirm_status
  #   confirmed = true if attendee_count >= minimum_attendees
  # end

  def attendee_cost
    if cost_per_person
      cost_per_person
    elsif flat_cost
      flat_cost/attendee_count
    end
  end

end

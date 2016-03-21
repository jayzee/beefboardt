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

  validates :name, :location, :event_time, :minimum_attendees, presence: true
  validates :minimum_attendees, numericality: true
  validate :either_cost_per_person_or_flat_cost, :deadline_before_event_time, :event_in_the_future


  def tags_attributes=(attributes)
    attributes.each do |k, tag|
      self.tags << Tag.find_or_create_by(tag) unless tag.values == [""]
    end
  end

  def deadline_before_event_time
    if signup_deadline >= event_time
      errors.add(:signup_deadline, " must be before the event time")
    end
  end

  def event_in_the_future
    if DateTime.now >= event_time
      errors.add(:event_time, " must be in the future")
    end
  end

  def either_cost_per_person_or_flat_cost
    if cost_per_person.present? && flat_cost.present?
      errors.add(:cost, " can't have a flat cost AND cost per person")
    end
  end

  def self.upcoming
    where('event_time > ?', DateTime.now).order('event_time DESC')
  end

  def self.past
    where('event_time < ?', DateTime.now)
  end

  def self.top_six
    upcoming.order('event_time DESC').limit(6)
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

  def check_confirm_status
    attendee_count >= minimum_attendees ? update(confirmed:true) : update(confirmed:false)
  end

  def attendee_cost
    if cost_per_person
      cost_per_person
    elsif flat_cost
      flat_cost/attendee_count
    end
  end


  def current_attendee_count
    self.minimum_attendees - self.attendee_count
  end
  
  def attendance_chart
    {"Missing Beef" => self.current_attendee_count, "Attendees" => self.attendee_count}
  end
  ###### OVERALL EVENT ANALYTICS ######

  def self.highest_attendance
    Event.joins(:attendees).group('events.id').order('count(events.id) DESC').limit(5)
  end

  def self.by_month
    where("event_time < ?", 3.months.from_now).group_by_month('events.event_time')
  end

  def self.by_day_of_week
    grouped = group_by_day_of_week(:event_time)
    grouped.transform_keys{ |key| Date::DAYNAMES[key.to_i] }
  end

  def self.percent_confirmed
    confirmed = group(:confirmed).count
    (confirmed[true].to_f/Event.upcoming.count) * 100
  end

  def self.paid_events
    where('flat_cost IS NOT NULL OR cost_per_person IS NOT NULL')
  end

  def self.free_events
    Event.all - paid_events
  end

  def self.avg_cost_for_paid_events
    total = 0
    paid_events.each { |event| total += event.attendee_cost }
    total / paid_events.joins(:attendees).count
  end

end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :attendees
  has_many :hosts
  # has_many :attended_events, :class_name => "Event", through: :attendees
  # has_many :hosted_events, :class_name => "Event", through: :hosts

  def name_w_initial
    "#{self.first_name}" + " " + "#{self.last_name.first}."
  end

  def hosting_events
    Event.joins("JOIN hosts ON events.id = hosts.event_id JOIN users ON hosts.user_id = users.id").where("hosts.user_id = ?", self.id)
    # Host.joins(:events).joins(:users).where("user.id = ?", self.id)
  end

  def attending_events
    Event.joins("JOIN attendees ON events.id = attendees.event_id JOIN users ON attendees.user_id = users.id").where("users.id = ?", self.id)
  end

end

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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :attendees
  has_many :hosts
  validates :first_name, :last_name, presence: :true
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

  def is_the_user_a_host(event)
    list_of_hosted_events = self.hosts.select do |host|
      host.user_id == self.id && host.event_id == event.id
    end

    list_of_hosted_events.count > 0
    
  end

  def is_the_user_an_attendee(event)
     event.attendees.include?(self)
     
  end

end

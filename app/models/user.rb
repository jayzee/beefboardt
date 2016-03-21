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

  def name_w_initial
    "#{self.first_name} #{self.last_name.first}."
  end

  def hosting_events
    Event.upcoming.joins(host: :user).where(hosts: {user_id:self.id})
  end

  def attending_events
    Event.upcoming.joins(attendees: :user).where(attendees: {user_id:self.id})
  end

  def attended_events
    Event.past.joins(attendees: :user).where(attendees: {user_id:self.id})
  end

  def all_events
    attended_events + attending_events
  end

end

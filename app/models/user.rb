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


end

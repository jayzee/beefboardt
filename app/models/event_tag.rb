# == Schema Information
#
# Table name: event_tags
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventTag < ActiveRecord::Base
  belongs_to :event
  belongs_to :tag
end

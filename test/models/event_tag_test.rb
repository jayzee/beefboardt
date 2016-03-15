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

require 'test_helper'

class EventTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

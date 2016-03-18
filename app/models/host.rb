# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Host < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def host_name
    user.name_w_initial
  end

  def host_email
    user.email
  end

  def host_phone
    user.phone
  end

end

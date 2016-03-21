# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :events_tags
  has_many :events, through: :tags
  validates :name, uniqueness: true


  def self.most_popular
    EventTag.joins(:tag).group(:name).count
  end
end

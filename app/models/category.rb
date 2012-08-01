# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base

  has_many :blogs

  def self.root
    Category.where('parent_id' => nil)
  end

  def children
    Category.where(:parent_id => self.id)
  end

end


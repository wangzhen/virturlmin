# == Schema Information
#
# Table name: blogs
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  content            :text
#  category_id        :integer
#  is_public          :boolean
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  public_datetime    :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Blog < ActiveRecord::Base
  
  validates :title , :presence => true
  validates :content , :presence => true
  validates :category_id , :presence => true

  belongs_to :category


end




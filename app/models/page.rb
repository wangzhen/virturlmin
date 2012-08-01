# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base

     before_save  :del_style
  def del_style
#    self.content = self.content.delete('<link href="/assets/style.css" media="screen" rel="stylesheet" type="text/css" />')
  end
end

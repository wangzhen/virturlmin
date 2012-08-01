# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  password   :string(255)
#  domain     :string(255)
#  start_date :datetime
#  end_data   :datetime
#  price      :integer
#  f          :string(255)
#  last_login :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class User < ActiveRecord::Base
  extend ActiveModel::Callbacks
    validates :name   ,:presence => true  ,:uniqueness  => true , :format => { :with => /[a-z]{4,}/i }
    validates :domain   ,:presence => true  ,:uniqueness  => true
    validates :password, :confirmation => true ,:presence => true 
 

    attr_accessible :name, :password, :password_confirmation ,:domain , :qq ,:tel , :email ,:domain2  ,:presence => true



end


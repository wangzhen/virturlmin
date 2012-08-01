# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  salted_password :string(255)
#  salt            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "digest/sha1"
class Administrator < ActiveRecord::Base

  define_model_callbacks :create

  before_create :set_salted_password
  attr_accessor :password

  validates :name   ,:presence => true #,:uniqueness  => true

  validates :password, :confirmation => true
  attr_accessible :name, :password, :password_confirmation
  #
  #  validates_confirmation_of :password
  #  validates_uniqueness_of :name
  #
  def self.authorize(name, password)
    admin = find_by_name(name)
    if admin && admin.salted_password == encrypt(password, admin.salt)
      return admin
    else
      return nil
    end
  end



  def set_salted_password

    unless password.blank?
      self.salt = self.class.encrypt("Generate Salt", Time.now.to_f)
      self.salted_password = self.class.encrypt(password, self.salt)
    end
  end

  protected
  def self.encrypt(string, salt)
    Digest::SHA1.hexdigest("#{string} - SHA1 - #{REST_AUTH_SITE_KEY} - #{salt}")
  end

end

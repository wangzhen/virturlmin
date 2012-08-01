class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :name
      t.string :salted_password
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :administrators
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :domain
      t.string :domain2
      t.datetime :start_date
      t.datetime :end_data
      t.integer :price
      t.string        :f
      t.datetime :last_login
      t.string :qq
      t.string :email
      t.string :tel
      t.timestamps
    end
  end
end

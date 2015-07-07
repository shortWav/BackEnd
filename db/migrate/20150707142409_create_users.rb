class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :username
      t.string :fullname
      t.string :accesstoken


      t.timestamps null: false
    end
  end





end

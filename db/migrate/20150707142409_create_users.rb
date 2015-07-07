class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :access_token


      t.timestamps null: false
    end
  end

end

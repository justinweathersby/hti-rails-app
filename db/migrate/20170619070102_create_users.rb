class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :profession
      t.string :device_token
      t.string :device_type
      t.string :auth_token
      t.integer :role

      t.timestamps
    end
  end
end

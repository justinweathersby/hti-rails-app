class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :user_id, index: true
      t.text :sent_to, array: true, default: []
      t.text :tokens, array: true, default: []

      t.timestamps
    end
  end
end

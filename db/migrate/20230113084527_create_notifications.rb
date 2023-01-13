class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :message_id, null: false
      t.boolean :confirmation_status, null: false, default: false


      t.timestamps
    end
  end
end

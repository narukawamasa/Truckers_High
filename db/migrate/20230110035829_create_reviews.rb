class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :driver_id, null: false
      t.integer :company_id, null: false
      t.integer :objective, null: false, default: 0
      t.text :method, null: false
      t.string :baggage, null: false
      t.string :vehicle, null: false
      t.string :reception_time, null: false
      t.text :order, null: false
      t.string :waiting_place, null: false
      t.text :other
      t.boolean :deletion, null: false, default: false


      t.timestamps
    end
  end
end

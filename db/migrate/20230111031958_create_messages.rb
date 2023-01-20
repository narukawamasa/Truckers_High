class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :messageable, type: :integer, polymorphic: true
      t.integer :room_id, foreign_key: true
      t.text :message, null: false

      t.timestamps
    end
  end
end

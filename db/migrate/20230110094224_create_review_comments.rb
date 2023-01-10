class CreateReviewComments < ActiveRecord::Migration[6.1]
  def change
    create_table :review_comments do |t|
      t.integer :driver_id, null: false
      t.integer :review_id, null: false
      t.text :comment, null: false
      t.boolean :deletion, null: false, default: false

      t.timestamps
    end
  end
end

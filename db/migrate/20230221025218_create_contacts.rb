class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      
      t.integer :contactable_id, null: false
      t.string :contactable_type, null: false
      t.integer :contact_company_id
      t.integer :category, null: false, default: 2
      t.text :text, null: false
      t.integer :status, null: false, default: 0
      t.string :admin_comment
      

      t.timestamps
    end
  end
end

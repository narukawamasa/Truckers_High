class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|

      t.string :name, null: false
      t.string :postal_code
      t.string :address, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end

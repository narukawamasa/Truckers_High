class CreatePossessionLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :possession_licenses do |t|

      t.integer :driver_id, null: false
      t.integer :license_id, null: false

      t.timestamps
    end
  end
end

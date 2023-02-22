class AddIsDeletedToDrivers < ActiveRecord::Migration[6.1]
  def change
    add_column :drivers, :is_deleted, :boolean, default: false
  end
end

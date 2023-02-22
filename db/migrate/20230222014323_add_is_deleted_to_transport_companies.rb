class AddIsDeletedToTransportCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :transport_companies, :is_deleted, :boolean, default: false
  end
end

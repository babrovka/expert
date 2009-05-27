class AddStatusIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :status_id, :integer
  end

  def self.down
    remove_column :orders, :status_id
  end
end

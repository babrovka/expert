class RemoveStatusFromOrders < ActiveRecord::Migration
  def self.up
     remove_column :orders, :status
  end

  def self.down
     add_column :orders, :status, :string
  end
end

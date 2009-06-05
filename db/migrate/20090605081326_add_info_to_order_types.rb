class AddInfoToOrderTypes < ActiveRecord::Migration
  def self.up
    add_column :order_types, :info, :text
    add_column :order_types, :active, :boolean
  end

  def self.down
    remove_column :order_types, :active
    remove_column :order_types, :info
  end
end

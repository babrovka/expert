class AddPriceToOrderTypes < ActiveRecord::Migration
  def self.up
    add_column :order_types, :price, :integer
  end

  def self.down
    remove_column :order_types, :price
  end
end

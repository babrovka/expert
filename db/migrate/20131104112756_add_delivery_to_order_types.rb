class AddDeliveryToOrderTypes < ActiveRecord::Migration
  def change
    add_column :order_types, :delivery, :boolean
  end
end

class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :order_type_id
      t.integer :user_id
      t.string :status
      t.boolean :payment
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

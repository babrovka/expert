class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries, :force => true do |t|
      t.column :order_id, :integer
      t.column :zip, :string
      t.column :city, :string
      t.column :address, :string
      t.column :comment, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end

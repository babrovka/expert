class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :order_id
      t.integer :sum
      t.datetime :payment_date
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end

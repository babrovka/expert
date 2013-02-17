class CreateOrderPayments < ActiveRecord::Migration
  def change
    create_table :order_payments do |t|
      t.references :order
      t.string :payment_num
      t.date :payment_date
      t.text :comment

      t.timestamps
    end
    add_index :order_payments, :order_id
  end
end

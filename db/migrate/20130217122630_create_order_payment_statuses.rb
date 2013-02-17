class CreateOrderPaymentStatuses < ActiveRecord::Migration
  def change
    create_table :order_payment_statuses do |t|
      t.references :order
      t.string :status

      t.timestamps
    end
    add_index :order_payment_statuses, :order_id
  end
end

class AddStatusSumToOrderPayment < ActiveRecord::Migration
  def change
    add_column :order_payments, :status, :integer, default: 0
    add_column :order_payments, :sum, :string
  end
end

class OrderPayment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :comment, :payment_date, :payment_num
end

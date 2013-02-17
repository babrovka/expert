class OrderPaymentStatus < ActiveRecord::Base
  belongs_to :order
  attr_accessible :status
end

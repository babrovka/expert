class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_type

  has_many :messages
  accepts_nested_attributes_for :messages

  attr_protected :user_id, :status, :sum, :payment
end

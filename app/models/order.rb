class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_type
  belongs_to :status

  has_many :messages
  accepts_nested_attributes_for :messages

  attr_protected :user_id, :status, :sum, :payment
  default_scope :order=>'created_at desc'
end

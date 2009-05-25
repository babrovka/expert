class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_type

  has_many :messages
  accepts_nested_attributes_for :messages

end

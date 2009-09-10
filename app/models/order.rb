class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_type
  belongs_to :status
  has_many :messages
  has_many :payments
  has_one :delivery

  accepts_nested_attributes_for :messages

  attr_protected :user_id, :status, :sum, :payment
  default_scope :order=>'created_at desc'


  def paid_for?
     price && price>0 && price<=payments.sum(:sum)
  end

end

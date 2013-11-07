class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_type
  belongs_to :status
  has_many :messages
  has_many :payments
  has_one :delivery
  has_one :order_payment
  has_one :order_payment_status

  accepts_nested_attributes_for :messages

  attr_protected :user_id, :status, :sum, :payment
  default_scope :order => 'created_at desc'

  validates_presence_of :status

  def paid_for?
     price && price>0 && price<=payments.sum(:sum) || order_payment.try(:status) == 2
  end

  def with_empty_message
    messages.build
    5.times { messages[0].documents.build }
    self
  end
end

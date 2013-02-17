# encoding: utf-8

class OrderPayment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :comment, :payment_date, :payment_num, :sum, :status

  STATUSES = {:'0' => 'Ожидает оплаты', :'1' => 'Частично оплачен', :'2' => 'Оплачен'}

  def status_name
    STATUSES[self.status.to_s.to_sym]
  end

end

# encoding: utf-8
class OrderType < ActiveRecord::Base
  has_many :orders
  
  scope :active, where(:active => true)

  def name_with_price
    price && price>0 ? "#{name} - #{price} рублей" : "#{name} - бесплатно"
  end

end

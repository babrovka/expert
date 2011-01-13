class OrderType < ActiveRecord::Base
  has_many :orders
  
  named_scope :active, :conditions=>'active'

  def name_with_price
    price && price>0 ? "#{name} - #{price} рублей" : "#{name} - бесплатно"
  end

end

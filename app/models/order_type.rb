class OrderType < ActiveRecord::Base
  has_many :orders
  

  def name_with_price
    "#{name} - #{price} рублей"
  end

end

class OrderType < ActiveRecord::Base
  has_many :orders
  
  named_scope :active, :conditions=>'active'

  def name_with_price
    "#{name} - #{price} рублей"
  end

end

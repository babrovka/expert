class Delivery < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :address, :message=>"Пожалуйста, укажите адрес доставки"
  validates_presence_of :city, :message=>"Пожалуйста, укажите город доставки"

  def full_address
    "#{zip} #{city} #{address}"
  end
end

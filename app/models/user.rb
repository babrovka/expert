class User < ActiveRecord::Base
  has_many :orders
  acts_as_authentic do |o|
    o.validate_password_field = false
  end


  def admin?
    id==1
  end

end

class User < ActiveRecord::Base
  has_many :orders
  has_many :messages
  
  attr_protected :admin

  acts_as_authentic do |o|
    o.validate_password_field = false
  end

  def admin?
    admin
  end


  def supervisor?
    id==1
  end


end

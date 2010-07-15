class User < ActiveRecord::Base
  has_many :orders
  has_many :messages

  attr_protected :admin

  acts_as_authentic do |o|
    o.validates_format_of_email_field_options={:with => Authlogic::Regex.email, :message=>"необходим правильный электронный адрес"}
    o.require_password_confirmation=false
  end

  def admin?
    admin
  end


  def supervisor?
    id==1
  end


  def deliver_password_reset_instructions!
    reset_perishable_token!
    OrderMailer.deliver_password_reset_instructions(self)
  end

end


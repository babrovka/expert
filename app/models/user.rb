class User < ActiveRecord::Base
  acts_as_authentic do |o|
    o.validate_password_field = false
  end
end

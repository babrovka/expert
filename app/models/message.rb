class Message < ActiveRecord::Base
  belongs_to :order
  has_many :attachments
end

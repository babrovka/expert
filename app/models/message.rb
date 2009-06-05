class Message < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :documents, :dependent=>:delete_all
  accepts_nested_attributes_for :documents
  default_scope :order=>'created_at desc'
end

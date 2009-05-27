class Document < ActiveRecord::Base
  belongs_to :message
  has_attached_file :file,
     :path => ":rails_root/downloads/:attachment/:id/:style/:basename.:extension",
     :url => ":attachment/:id/:style/:basename.:extension"
  validates_attachment_size :file, :less_than => 10.megabytes, :message=>"Слишком большой файл, попробуйте его заархивировать"
end

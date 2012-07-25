# encoding: utf-8
class Document < ActiveRecord::Base
  belongs_to :message
  has_attached_file :file,
     :path => ":rails_root/downloads/:attachment/:id/:style/:basename.:extension",
     :url => ":attachment/:id/:style/:basename.:extension"
  validates_attachment_size :file, :less_than => 10.megabytes, :message=>"Слишком большой файл, попробуйте его заархивировать"

  def public_file_name
     if file_file_name && file_file_name.length>27
        file_file_name.gsub(File.extname(file_file_name),"")[0..27]+"__"+File.extname(file_file_name)
     else
        file_file_name
     end

 
  end
end

# encoding: utf-8
class DocumentsController < ApplicationController

  before_filter :require_user

  def download
     doc=Document.find(params[:id])
     if doc.message.order.user==current_user || current_user.admin?
        #Set the X-Accel-Redirect header with the path relative to the /downloads location in nginx
        response.headers['X-Accel-Redirect'] = "/downloads/#{doc.file.url}"
      	#Set the Content-Type header as nginx won't change it and Rails will send text/html
	      response.headers['Content-Type'] = 'application/octet-stream'
      	#If you want to force download, set the Content-Disposition header (which nginx won't change)
      	response.headers['Content-Disposition'] = "attachment; filename=#{doc.file_file_name}"
      	render :nothing => true
     else
       flash[:notice]="Документ не доступен"
       redirect_to :back
     end
  end



end


# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def to_russian_date(date)
    Russian::strftime(date, "%d %B %Y %H:%M")
  end


 def errors_for(object, method)
   if object
     errs=object.errors[method]
     if errs
        text=errs.is_a?(Array) ? errs.join(', ') : errs
     end
     if text
       "<div class='error'>#{text}</div>"
     else
       nil 
     end
   end
 end

end

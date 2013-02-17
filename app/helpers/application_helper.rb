# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def to_russian_date(date)
    Russian::strftime(date, "%d %B %Y %H:%M")
  end

  def short_date(date)
    date.strftime("%d.%m.%Y")
  end

 def errors_for(object, method)
   if object
     errs = object.errors[method]
     if errs.present?
        text = errs.is_a?(Array) ? errs.join(', ') : errs
     end
     if text
       raw "<div class='error'>#{text}</div>"
     else
       nil
     end
   end
 end

 def main_page?
   request.fullpath == '/'
 end

 def format_date_user(date)
   date.try(:strftime, '%d.%m.%Y')
 end

 def error_messages_for(obj)
   obj = instance_variable_get("@#{obj}") if obj.is_a?(Symbol)
   return "" unless obj
   text = ""
   obj.errors.full_messages.each do |msg|
     text << "<p>#{msg}</p>"
   end
   raw text
 end
end


# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def to_russian_date(date)
    Russian::strftime(date, "%d %B %Y %H:%M")
  end

end

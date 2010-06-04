module ApplicationHelper
  
  def page_title(title = "")
    if title.present?
      @title = t(title)
    else
      return "#{@title || action_name}"
    end
  end
  
end

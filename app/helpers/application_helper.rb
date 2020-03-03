module ApplicationHelper
  def current(controller)
    return "current" if controller == params[:controller]
  end
end

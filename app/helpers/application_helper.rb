module ApplicationHelper
  def is_current(controller)
    return "is-current" if controller == params[:controller]
  end
end

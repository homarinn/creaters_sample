module ApplicationHelper
  def is_current(controller)
    return "is-current" if current_controller?(controller)
  end

  def current_controller?(controller)
    return true if controller == params[:controller]
  end
end

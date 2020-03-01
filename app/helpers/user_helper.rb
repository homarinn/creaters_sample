module UserHelper
  def display_user_icon(size: 40)
    image_tag current_user.decorate.icon_for_display(size), size: size, class: 'user-icon'
  end
end
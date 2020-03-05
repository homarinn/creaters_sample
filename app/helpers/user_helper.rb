module UserHelper
  def user_icon(size: 40)
    image_tag current_user.decorate.icon_for_display(size), size: size, class: 'm-user-icon'
  end
end
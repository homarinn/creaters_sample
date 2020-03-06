class UserDecorator < Draper::Decorator
  delegate_all

  def icon_for_display(size)
    icon = object.icon.attached? ? object.icon.variant(resize: "#{size}x#{size}").processed : 'no-icon.png'
    helpers.image_tag icon, size: size, class: 'm-user-icon'
  end

end

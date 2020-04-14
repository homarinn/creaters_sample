class UserDecorator < Draper::Decorator
  delegate_all

  def icon_for_display(size)
    begin
      icon = object.icon.attached? ? object.icon.variant(resize: "#{size}x#{size}").processed : 'no-icon.png'
      h.image_tag icon, size: size, class: 'm-user-icon'
    rescue => e
      h.image_tag 'no-icon.png', size: size, class: 'm-user-icon'
    end
  end

end

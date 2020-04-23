class UserDecorator < Draper::Decorator
  delegate_all

  def icon_for_display(size, preview: false)
    class_name = preview ? 'm-user-icon preview' : 'm-user-icon'
    begin
      icon = object.icon.attached? ? object.icon.variant(resize: "#{size}x#{size}").processed : 'no-icon.png'
      h.image_tag icon, size: size, class: class_name
    rescue => e
      h.image_tag 'no-icon.png', size: size, class: class_name
    end
  end

end

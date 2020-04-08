class ComicDecorator < SingleWorkDecorator
  delegate_all

  def images_for_display(width: 360)
    return unless object.images.attached?
    height = width*5/4
    object.images.each do |image|
      h.concat h.image_tag image.variant(resize_to_fit: [width, height]).processed, class: 'm-image'
    end
  end
end
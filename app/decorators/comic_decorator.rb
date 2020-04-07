class ComicDecorator < SingleWorkDecorator
  delegate_all

  def images_for_display(width: 360)
    height = width*5/4
    if object.images.attached?
      object.images.each do |image|
        h.concat h.image_tag image.variant(resize_to_fit: [width, height]).processed, class: 'm-image'
      end
    else
      h.image_tag 'no-image.png', width: width, height: height, class: 'm-image'
    end
  end
end
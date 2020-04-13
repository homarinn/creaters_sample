class IllustrationDecorator < SingleWorkDecorator
  delegate_all

  def image_for_display(width: 360)
    height = width*5/4
    if object.image.attached?
      h.image_tag object.image.variant(resize_to_fit: [width, height]).processed, class: 'm-image'
    else
      h.image_tag 'no-image.png', width: width, height: height, class: 'm-image'
    end
  end
end
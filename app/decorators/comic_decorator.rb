class ComicDecorator < SingleWorkDecorator
  delegate_all

  def thumbnail_for_display(width: 160)
    height = width*5/4
    if object.images.attached?
      h.image_tag object.images.first.variant(resize_to_fit: [width, height]).processed, class: 'm-image'
    else
      h.image_tag 'no-image.png', width: width, height: height, class: 'm-image'
    end
  end

  def images_for_display(width: 600)
    height = width*5/4
    if object.images.attached?
      h.content_tag :div, class: 'comic-images' do
        object.images.each do |image|
          h.concat h.image_tag image.variant(resize_to_fit: [width, height]).processed, class: 'm-image'
        end
      end
    else
      h.image_tag 'no-image.png', width: width, height: height, class: 'm-image'
    end
  end
end
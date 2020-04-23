class SeriesDecorator < WorkDecorator
  delegate_all

  def thumbnail_for_display(width: 100)
    height = width*5/4
    begin
      if object.thumbnail.attached?
        h.image_tag object.thumbnail.variant(resize_to_fit: [width, height]).processed, class: 'm-thumbnail'
      else
        h.image_tag 'no-image.png', width: width, height: height, class: 'm-thumbnail'
      end
    rescue => e
      h.image_tag 'no-image.png', width: width, height: height, class: 'm-thumbnail'
    end
  end

  def form_path(controller, action)
    path = "/#{controller.gsub("series/", "")}"
    action ==  "new" ? path : "#{path}/#{object.id}"
  end

  def outline_name
    object.is_illustration_series? ? "概要" : "あらすじ"
  end

  def operation_item_text_post_next_episode
    object.is_illustration_series? ? "次の絵を投稿" : "次の話を投稿"
  end

  def operation_item_text_change_status
    object.public_posted? ? "非公開にする" : "公開する"
  end
end
class NovelDecorator < ApplicationDecorator
  delegate_all

  def thumbnail_for_display(width: 100)
    height = width*5%4
    thumbnail = object.thumbnail.attached? ? object.thumbnail.variant(resize: "#{width}x#{height}").processed : 'no-thumbnail.png'
    helpers.image_tag thumbnail, width: width, height: height, class: 'm-thumbnail'
  end

  def type_for_display
    case object.class
    when 'Novel' then '短編小説'
    when 'NovelSeries' then '連載小説'
    end
  end
end

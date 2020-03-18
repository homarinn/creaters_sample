class WorkDecorator < ApplicationDecorator
  delegate_all

  def thumbnail_for_display(width: 100)
    height = width*5/4
    if object.thumbnail.attached?
      h.image_tag object.thumbnail.variant(resize_to_fit: [width, height]).processed, class: 'm-thumbnail'
    else
      h.image_tag 'no-thumbnail.png', width: width, height: height, class: 'm-thumbnail'
    end
  end

  def type_for_display
    case object.class.name
    when 'Novel' then '短編小説'
    when 'NovelSeries' then '連載小説'
    when 'Illustration' then '単体イラスト'
    when 'IllustrationSeries' then 'イラスト集'
    when 'Comic' then '読み切り'
    when 'ComicSeries' then '連載漫画'
    end
  end
end
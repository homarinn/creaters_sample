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

  def type_for_display(link: true)
    type_name = case object.class.name
    when 'Novel' then '短編小説'
    when 'NovelSeries' then '連載小説'
    when 'Illustration' then '単体イラスト'
    when 'IllustrationSeries' then 'イラスト集'
    when 'Comic' then '読み切り'
    when 'ComicSeries' then '連載漫画'
    end
    if link
      h.content_tag :a, type_name, href: "/#{object.class.name.tableize}", class: "work-type-link"
    else
      type_name
    end
  end

  def genre_for_display(link: true)
    return if object.genre_id.blank?
    if link
      h.content_tag :a, object.genre.name, href: "/#{object.genre.path_name}", class: "genre-link"
    else
      object.genre.name
    end
  end
end
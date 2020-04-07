class WorkDecorator < ApplicationDecorator
  delegate_all

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
      h.link_to type_name, "/#{object.class.name.tableize}", class: "work-type-link"
    else
      type_name
    end
  end

  def genre_for_display(link: true)
    return if object.genre_id.blank?
    if link
      h.link_to object.genre.name, "/#{object.genre.path_name}", class: "genre-link"
    else
      object.genre.name
    end
  end

  def belongs_to_genre?
    case object.class.name
    when 'Illustration', 'IllustrationSeries' then false
    else object.genre_id.present?
    end
  end

  def is_series?
    case object.class.name
    when 'NovelSeries', 'IllustrationSeries', 'ComicSeries' then true
    else false
    end
  end

  def is_novel_or_novel_series?
    case object.class.name
    when 'Novel', 'NovelSeries' then true
    else false
    end
  end

  # 命名不安
  def update_for_display
    return "（改）" if object.updated_at > object.posted_at
  end

  def form_path(action)
    action ==  "new" ? "/manage/#{object.class.name.tableize}" : "/manage/#{object.class.name.tableize}/#{object.id}"
  end
end
class WorkDecorator < ApplicationDecorator
  delegate_all

  def type_for_display(link: true, simple: false)
    type_name = case object.class.name
    when 'Novel'
      simple ? '短編' : '短編小説'
    when 'NovelSeries'
      simple ? '連載' : '連載小説'
    when 'Illustration'
      simple ? '単体' : '単体イラスト'
    when 'IllustrationSeries'
      simple ? '画集' : 'イラスト集'
    when 'Comic'
      simple ? '読切' : '読み切り'
    when 'ComicSeries'
      simple ? '連載' : '連載漫画'
    end

    return type_name unless link

    h.link_to type_name, "/#{object.class.name.tableize}", class: "work-type-link"
  end

  def genre_for_display(link: true)
    return if object.genre_id.blank?
    return object.genre.name unless link

    h.link_to object.genre.name, "/#{object.genre.path_name}", class: "genre-link"
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

  def update_mark
    return "（改）" if object.updated_at > object.posted_at
  end

  def form_path(action)
    action ==  "new" ? "/manage/#{object.class.name.tableize}" : "/manage/#{object.class.name.tableize}/#{object.id}"
  end
end
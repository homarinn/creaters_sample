class NovelDecorator < WorkDecorator
  delegate_all

  def novel_series_for_display(link: true)
    return if object.novel_series_id.blank?
    if link
      h.link_to object.novel_series.title, object.novel_series, class: "novel-series-link"
    else
      object.novel_series.title
    end
  end
end

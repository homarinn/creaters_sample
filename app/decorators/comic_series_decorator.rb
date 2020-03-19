class NovelSeriesDecorator < SeriesDecorator
  delegate_all

  def detail
    h.content_tag :div, class: "series-detail-box" do
      h.concat h.content_tag :div, "連載漫画", class: "series-type"
      h.concat h.content_tag :div, object.genre.name, class: "series-genre"
      h.concat h.content_tag :div, "#{object.works_count}話", class: "series-count"
    end
  end
end
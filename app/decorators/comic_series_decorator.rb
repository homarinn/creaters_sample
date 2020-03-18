class NovelSeriesDecorator < SeriesDecorator
  delegate_all

  def detail
    h.content_tag :div, class: "series-detail-box" do
      h.content_tag :div, "連載漫画", class: "series-type"
      h.content_tag :div, object.genre.name, class: "series-genre"
      h.content_tag :div, "#{object.comics_count}話", class: "series-count"
    end
  end
end
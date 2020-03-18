class NovelSeriesDecorator < SeriesDecorator
  delegate_all

  def detail
    h.content_tag :div, class: "series-detail-box" do
      h.concat h.content_tag :div, "連載小説", class: "series-type"
      h.concat h.content_tag :div, object.genre.name, class: "series-genre"
      h.concat h.content_tag :div, "#{object.words_count}文字", class: "series-words-count"
    end
  end
end
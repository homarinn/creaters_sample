class IllustrationSeriesDecorator < SeriesDecorator
  delegate_all

  def detail
    h.content_tag :div, class: "series-detail-box" do
      h.content_tag :div, "イラスト集", class: "series-type"
      h.content_tag :div, "#{object.illustrations_count}枚", class: "series-count"
    end
  end
end
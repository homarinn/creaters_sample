class IllustrationSeriesDecorator < SeriesDecorator
  delegate_all

  def detail
    h.content_tag :div, class: "series-detail-box" do
      h.concat h.content_tag :div, "イラスト集", class: "series-type"
      h.concat h.content_tag :div, "#{object.works_count}枚", class: "series-count"
    end
  end
end
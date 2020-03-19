class NovelSeriesDecorator < SeriesDecorator
  delegate_all

  def words_count_row
    h.content_tag :tr, class: "series-detail-table-row" do
      h.concat h.content_tag :td, "文字数", class: "series-detail-table-row__data series-detail-table-row__data--label"
      h.concat h.content_tag :td, "#{object.words_count}文字", class: "series-detail-table-row__data series-detail-table-row__data--status"
    end
  end
end
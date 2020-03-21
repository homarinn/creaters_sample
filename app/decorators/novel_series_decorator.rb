class NovelSeriesDecorator < SeriesDecorator
  delegate_all

  def words_count_row
    h.content_tag :tr, class: "work-detail-table-row" do
      h.concat h.content_tag :td, "文字数", class: "work-detail-table-row__data work-detail-table-row__data--label"
      h.concat h.content_tag :td, "#{object.words_count}文字", class: "work-detail-table-row__data work-detail-table-row__data--status"
    end
  end
end
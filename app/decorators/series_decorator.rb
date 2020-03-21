class SeriesDecorator < WorkDecorator
  delegate_all

  def works_count_row
    unit = case object.type
    when "NovelSeries" then "話"
    when "IllustrationSeries" then "枚"
    when "ComicSeries" then "話"
    end

    h.content_tag :tr, class: "work-detail-table-row" do
      h.concat h.content_tag :td, "#{unit}数", class: "work-detail-table-row__data work-detail-table-row__data--label"
      h.concat h.content_tag :td, "#{object.works_count}#{unit}", class: "work-detail-table-row__data work-detail-table-row__data--status"
    end
  end
end
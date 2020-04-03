class NovelDecorator < WorkDecorator
  delegate_all

  def novel_series_for_display(link: true)
    return if !object.series_episode?
    if link
      h.link_to object.novel_series.title, object.novel_series, class: "novel-series-link"
    else
      object.novel_series.title
    end
  end

  def story_number_for_display
    novels = object.novel_series.novels
    story_number = novels.index(object)+1
    "#{story_number}/#{novels.size}"
  end

  def next_and_prev_story_link
    novels = object.novel_series.novels
    story_index = novels.index(object)
    case story_index
    when 0
      h.link_to "次へ >>", novels[story_index+1], class: "next-link" if novels.size != 1
    when novels.size-1
      h.link_to "<< 前へ", novels[story_index-1], class: "prev-link"
    else
      h.concat h.link_to "<< 前へ", novels[story_index-1], class: "prev-link"
      h.concat h.link_to "次へ >>", novels[story_index+1], class: "next-link"
    end
  end

  def form_path(action)
    action ==  "new" ? "/manage/novels" : "/manage/novels/#{object.id}"
  end
end

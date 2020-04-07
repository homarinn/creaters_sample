class SingleWorkDecorator < WorkDecorator
  delegate_all

  def form_path(action)
    action ==  "new" ? "/manage/#{object.class.name.tableize}" : "/manage/#{object.class.name.tableize}/#{object.id}"
  end

  def episode_number_for_display
    works = object.class.name.tableize
    work_series = "#{object.class.name}Series".tableize
    episodes = object.send(work_series).send(works)
    episode_number = episodes.index(object)+1
    "#{episode_number}/#{episodes.size}"
  end

  def next_and_prev_episode_link
    works = object.class.name.tableize
    work_series = "#{object.class.name}Series".tableize
    episodes = object.send(work_series).send(works)
    episode_index = episodes.index(object)
    case episode_index
    when 0
      h.link_to "次へ >>", episodes[episode_index+1], class: "next-link" if episodes.size != 1
    when episodes.size-1
      h.link_to "<< 前へ", episodes[episode_index-1], class: "prev-link"
    else
      h.concat h.link_to "<< 前へ", episodes[episode_index-1], class: "prev-link"
      h.concat h.link_to "次へ >>", episodes[episode_index+1], class: "next-link"
    end
  end

  def work_series_for_display(link: true)
    work_series = "#{object.class.name}Series".tableize
    return unless object.send(work_series)
    if link
      h.link_to object.send(work_series).title, object.send(work_series), class: "novel-series-link"
    else
      object.send(work_series).title
    end
  end
end
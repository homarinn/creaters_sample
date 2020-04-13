module HomeHelper
  def series_list_link(series)
    if series.present?
      return link_to "もっと見る >>", eval("#{@work_type}_series_index_path(keyword: @keyword)"), class: 'list-link' if @keyword
      return link_to "もっと見る >>", "/#{@work_type}_series", class: 'list-link'
    end

    link_name = t("#{@work_type}_series".classify) + '一覧 >>'
    link_to link_name, "/#{@work_type}_series", class: 'list-link'
  end

  def single_list_link(works)
    if works.present?
      return link_to "もっと見る >>", eval("#{@work_type}s_path(keyword: @keyword)"), class: 'list-link' if @keyword
      return link_to "もっと見る >>", "/#{@work_type}s", class: 'list-link'
    end

    link_name = t(@work_type.classify) + '一覧 >>'
    link_to link_name, "/#{@work_type}s", class: 'list-link'
  end
end
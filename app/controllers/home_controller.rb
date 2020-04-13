class HomeController < ApplicationController
  before_action :set_keyword
  before_action :set_meta_name

  def top
    @novel_series = Search::NovelSeries.run(simple_search_params).new_posted_list
    @illustration_series = Search::IllustrationSeries.run(simple_search_params).new_posted_list
    @comic_series = Search::ComicSeries.run(simple_search_params).new_posted_list
  end

  def novels
    @work_type = 'novel'
    set_works_work_series
  end

  def illustrations
    @work_type = 'illustration'
    set_works_work_series
  end

  def comics
    @work_type = 'comic'
    set_works_work_series
  end

  private

    def set_keyword
      @keyword = params[:keyword] if params[:keyword].present?
    end

    def set_meta_name
      @meta_name = params[:keyword] ? "検索結果一覧" : "新着一覧"
    end

    def set_works_work_series
      instance_variable_set("@#{@work_type}_series", "Search::#{@work_type.camelize}Series".constantize.run(simple_search_params).new_posted_list)
      instance_variable_set("@#{@work_type.pluralize}", "Search::#{@work_type.pluralize.camelize}".constantize.run(simple_search_params).new_posted_list)
    end

    def simple_search_params
      params.permit(:keyword)
    end
end

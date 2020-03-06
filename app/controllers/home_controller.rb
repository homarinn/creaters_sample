class HomeController < ApplicationController
  before_action :set_keyword, only: [:novels, :illustrations, :comics]
  before_action :set_meta_name, only: [:novels, :illustrations, :comics]

  def top
  end

  def novels
    set_works_work_series(work_type: "novel")
  end

  def illustrations
    set_works_work_series(work_type: "illustration")
  end

  def comics
    set_works_work_series(work_type: "comic")
  end

  private

    def set_keyword
      @keyword = params[:keyword] if params[:keyword].present?
    end

    def set_meta_name
      @meta_name = params[:keyword] ? "検索結果一覧" : "新着一覧"
    end

    def set_works_work_series(work_type:)
      if @keyword.present?
        instance_variable_set("@#{work_type}_series", "Search::#{work_type.camelize}Series".constantize.run(simple_search_params))
        instance_variable_set("@#{work_type.pluralize}", "Search::#{work_type.pluralize.camelize}".constantize.run(simple_search_params))
      else
        instance_variable_set("@#{work_type}_series", "#{work_type.camelize}Series".constantize.new_posted_list)
        instance_variable_set("@#{work_type.pluralize}", work_type.camelize.constantize.new_posted_list)
      end
    end

    def simple_search_params
      params.permit(:keyword)
    end
end

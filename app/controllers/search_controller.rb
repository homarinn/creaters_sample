class SearchController < ApplicationController
  before_action :set_search_type, only: :index

  def index
    if params[:keyword].present?
      @keyword = params[:keyword]
      @count = 0
      %w(novel illustration comic).each do |work|
        work_name = case @work_type
        when "series" then "#{work}_series"
        when "single" then work.pluralize
        end

        search_class = "Search::#{work_name.camelize}".constantize
        instance_variable_set("@#{work_name}", search_class.run(search_params))
        @count += eval("@#{work_name}.size")
      end
    end
  end

  private

    def search_params
      params.permit(:keyword)
    end

    def set_search_type
      @work_type = params[:work_type]
    end
end
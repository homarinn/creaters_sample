module SeriesController
  extend ActiveSupport::Concern

  included do
    before_action :set_type
    before_action :set_series, only: :show

    def index
      @series = "Search::#{@type.classify}".constantize.run(simple_search_params).order(updated_at: :desc).page(params[:page]).per(100)
    end

    def show
    end

    private

      def set_type
        @type = params[:controller].gsub('series/', "")
      end

      def set_series
        @series = @type.classify.constantize.find(params[:id])
      end

      def simple_search_params
        params.permit(:keyword)
      end
  end
end
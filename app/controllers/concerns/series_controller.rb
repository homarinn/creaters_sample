module SeriesController
  extend ActiveSupport::Concern

  included do
    before_action :set_type
    before_action :set_series, only: :show

    def index
      @series = @type.classify.constantize.all.order(updated_at: :desc)
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
  end
end
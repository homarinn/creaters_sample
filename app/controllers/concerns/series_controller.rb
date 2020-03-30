

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

      # def flash_message(success: )
      #   action = case params[:action]
      #   when 'create' then '作成'
      #   when 'edit' then '編集'
      #   end

      #   success ? "#{type_name}を#{action}しました" : "#{type_name}の#{action}に失敗しました"
      # end

      # def type_name
      #   case @type
      #   when 'novel_series' then '連載小説'
      #   when 'illustration_series' then 'イラスト集'
      #   when 'comic_series' then '連載漫画'
      #   end
      # end
  end
end
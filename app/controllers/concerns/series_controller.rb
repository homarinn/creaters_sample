

module SeriesController
  extend ActiveSupport::Concern

  included do
    before_action :set_type
    before_action :set_series, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_series_user_is_current_user, only: [:edit, :update, :destroy]

    def index
      @series = @type.classify.constantize.all.order(updated_at: :desc)
    end

    def show
    end

    def new
      @series = current_user.send(@type).build
    end

    def create
      @series = current_user.send(@type).build(series_params)
      binding.pry
      if @series.save
        redirect_to @series, notice: flash_message(success: true)
      else
        flash.now[:error] = flash_message(success: false)
        render :new
      end
    end

    def edit
    end

    def update
      if @series.update(series_params)
        redirect_to @series, notice: flash_message(success: true)
      else
        flash.now[:error] = flash_message(success: false)
        render :edit
      end
    end

    def destroy
      @series.destroy
    end

    private

      def set_type
        @type = params[:controller].gsub('series/', "")
      end

      def series_params
        params.require(@type.to_sym).permit(:title, :outline, :thumbnail)
      end

      def set_series
        @series = @type.classify.constantize.find(params[:id])
      end

      def check_series_user_is_current_user
        redirect_to root_url, alert: 'あなたにはこれを行う権限がありません' unless @series.user == current_user
      end

      def flash_message(success: )
        action = case params[:action]
        when 'create' then '作成'
        when 'edit' then '編集'
        end

        success ? "#{type_name}を#{action}しました" : "#{type_name}の#{action}に失敗しました"
      end

      def type_name
        case @type
        when 'novel_series' then '連載小説'
        when 'illustration_series' then 'イラスト集'
        when 'comic_series' then '連載漫画'
        end
      end
  end
end
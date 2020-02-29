module SeriesController
  extend ActiveSupport::Concern

  included do
    before_action :set_series, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :check_series_user_is_current_user, only: [:edit, :update, :destroy]

    def show
    end

    def edit
    end

    private

      def destroy
        @series.destroy
      end

      def set_series
        @series = Series.find(params[:id])
      end

      def check_series_user_is_current_user
        redirect_to root_url, alert: 'あなたにはこれを行う権限がありません' unless @series.user == current_user
      end
  end
end
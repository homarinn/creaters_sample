class Manage::Series::IllustrationSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_illustration_series, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_illustration_series_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def show
  end

  def new
    @illustration_series = current_user.illustration_series.build
  end

  def create
    @illustration_series = current_user.illustration_series.build(illustration_series_params)
    if @illustration_series.save
      redirect_to manage_illustration_series_path(@illustration_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @illustration_series.update(illustration_series_params)
      redirect_to manage_illustration_series_path(@illustration_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @illustration_series.destroy
    redirect_to posted_manage_illustrations_path, alert: flash_message(success: true)
  end

  private

    def set_illustration_series
      @illustration_series = current_user.illustration_series.find_by(id: params[:id])
    end

    def check_illustration_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @illustration_series
    end

    def illustration_series_params
      params.require(:illustration_series).permit(:title, :outline, :genre_id, :thumbnail)
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      end
      success ? "イラスト集を#{action}しました" : "イラスト集の#{action}に失敗しました"
    end
end
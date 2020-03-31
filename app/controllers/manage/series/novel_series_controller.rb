class Manage::Series::NovelSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_novel_series, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_novel_series_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def show
  end

  def new
    @novel_series = current_user.novel_series.build
  end

  def create
    @novel_series = current_user.novel_series.build(novel_series_params)
    if @novel_series.save
      redirect_to manage_novel_series_path(@novel_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @novel_series.update(novel_series_params)
      redirect_to manage_novel_series_path(@novel_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @novel_series.destroy
    redirect_to posted_manage_novels_path, alert: flash_message(success: true)
  end

  private

    def set_novel_series
      @novel_series = current_user.novel_series.find_by(id: params[:id])
    end

    def check_novel_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @novel_series
    end

    def novel_series_params
      params.require(:novel_series).permit(:title, :outline, :genre_id, :thumbnail)
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      end
      success ? "連載小説を#{action}しました" : "連載小説の#{action}に失敗しました"
    end
end
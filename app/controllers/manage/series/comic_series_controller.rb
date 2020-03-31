class Manage::Series::ComicSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comic_series, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_comic_series_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def show
  end

  def new
    @comic_series = current_user.comic_series.build
  end

  def create
    @comic_series = current_user.comic_series.build(comic_series_params)
    if @comic_series.save
      redirect_to manage_comic_series_path(@comic_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @comic_series.update(comic_series_params)
      redirect_to manage_comic_series_path(@comic_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @comic_series.destroy
    redirect_to posted_manage_comics_path, alert: flash_message(success: true)
  end

  private

    def set_comic_series
      @comic_series = current_user.comic_series.find_by(id: params[:id])
    end

    def check_comic_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @comic_series
    end

    def comic_series_params
      params.require(:comic_series).permit(:title, :outline, :genre_id, :thumbnail)
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      end
      success ? "連載漫画を#{action}しました" : "連載漫画の#{action}に失敗しました"
    end
end
class Series::ComicSeriesController < ApplicationController
  before_action :set_comic_series, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_series_user_is_current_user, only: [:edit, :update, :destroy]

  def index
    # 単数系と複数形が同じで混同しやすいため、語尾にindexをつけている
    @comic_series_index = ComicSeries.all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @comic_series = current_user.comic_series.build
  end

  def create
    @comic_series = current_user.comic_series.build(comic_series_params)
    if @comic_series.save
      redirect_to comic_series_path(@comic_series), notice: "シリーズ(漫画)を作成しました"
    else
      flash.now[:error] = 'シリーズの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @comic_series.update(comic_series_params)
      redirect_to comic_series_path(@comic_series), notice: "シリーズ(漫画)を編集しました"
    else
      flash.now[:error] = 'シリーズの編集に失敗しました'
      render :edit
    end
  end

  def destroy
    @comic_series.destroy
  end

  private

    def set_comic_series
      @comic_series = ComicSeries.find(params[:id])
    end

    def comic_series_params
      params.require(:comic_series).permit(:title, :outline)
    end

    def check_series_user_is_current_user
      redirect_to root_url, alert: 'あなたにはこれを行う権限がありません' unless Series.find(params[:id]).user == current_user
    end
end

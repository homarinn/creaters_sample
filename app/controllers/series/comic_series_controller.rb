class Series::ComicSeriesController < ApplicationController
  include SeriesController

  def index
    # 単数系と複数形が同じで混同しやすいため、語尾にindexをつけている
    @comic_series_index = ComicSeries.all.order(updated_at: :desc)
  end

  def new
    @comic_series = current_user.comic_series.build
  end

  def create
    @comic_series = current_user.comic_series.build(comic_series_params)
    if @comic_series.save
      redirect_to comic_series_path(@comic_series), notice: "シリーズ(漫画)を作成しました"
    else
      flash.now[:error] = 'シリーズ(漫画)の作成に失敗しました'
      render :new
    end
  end

  def update
    if @series.update(comic_series_params)
      redirect_to comic_series_path(@series), notice: "シリーズ(漫画)を編集しました"
    else
      flash.now[:error] = 'シリーズの編集(漫画)に失敗しました'
      render :edit
    end
  end

  private

    def comic_series_params
      params.require(:comic_series).permit(:title, :outline, :thumbnail)
    end
end

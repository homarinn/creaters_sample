class Series::IllustrationSeriesController < ApplicationController
  include SeriesController

  def index
    # 単数系と複数形が同じで混同しやすいため、語尾にindexをつけている
    @illustration_series_index = IllustrationSeries.all.order(updated_at: :desc)
  end

  def new
    @illustration_series = current_user.illustration_series.build
  end

  def create
    @illustration_series = current_user.illustration_series.build(illustration_series_params)
    if @illustration_series.save
      redirect_to illustration_series_path(@illustration_series), notice: "シリーズ(イラスト)を作成しました"
    else
      flash.now[:error] = 'シリーズ(イラスト)の作成に失敗しました'
      render :new
    end
  end

  def update
    if @series.update(illustration_series_params)
      redirect_to illustration_series_path(@series), notice: "シリーズ(イラスト)を編集しました"
    else
      flash.now[:error] = 'シリーズ(イラスト)の編集に失敗しました'
      render :edit
    end
  end

  private

    def illustration_series_params
      params.require(:illustration_series).permit(:title, :outline, :thumbnail)
    end
end

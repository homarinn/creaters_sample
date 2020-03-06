class Series::NovelSeriesController < ApplicationController
  include SeriesController

  # def index
  #   @novel_series = NovelSeries.all.order(updated_at: :desc)
  # end

  # def new
  #   @novel_series = current_user.novel_series.build
  # end

  # def create
  #   @novel_series = current_user.novel_series.build(novel_series_params)
  #   if @novel_series.save
  #     redirect_to novel_series_path(@novel_series), notice: "シリーズ(小説)を作成しました"
  #   else
  #     flash.now[:error] = 'シリーズ(小説)の作成に失敗しました'
  #     render :new
  #   end
  # end

  # def update
  #   if @series.update(novel_series_params)
  #     redirect_to novel_series_path(@series), notice: "シリーズ(小説)を編集しました"
  #   else
  #     flash.now[:error] = 'シリーズ(小説)の編集に失敗しました'
  #     render :edit
  #   end
  # end

  # private

  #   def novel_series_params
  #     params.require(:novel_series).permit(:title, :outline, :thumbnail)
  #   end
end

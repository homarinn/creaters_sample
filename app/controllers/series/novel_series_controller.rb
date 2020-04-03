class Series::NovelSeriesController < ApplicationController
  include SeriesController

  def show
    @novels = @series.novels.page(params[:page]).per(100)
  end

end

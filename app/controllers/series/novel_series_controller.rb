class Series::NovelSeriesController < ApplicationController
  include SeriesController

  def show
    @novels = Kaminari.paginate_array(@series.novels).page(params[:page]).per(100)
  end

end

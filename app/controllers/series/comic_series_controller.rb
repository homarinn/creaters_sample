class Series::ComicSeriesController < ApplicationController
  include SeriesController

  def show
    @comics = Kaminari.paginate_array(@series.comics).page(params[:page]).per(100)
  end
end

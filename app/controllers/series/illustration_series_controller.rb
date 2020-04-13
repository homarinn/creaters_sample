class Series::IllustrationSeriesController < ApplicationController
  include SeriesController

  def show
    @illustrations = Kaminari.paginate_array(@series.illustrations).page(params[:page]).per(100)
  end
end

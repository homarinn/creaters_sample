class Series::NovelSeriesController < ApplicationController
  include SeriesController

  def show
    @novels = Kaminari.paginate_array(@series.novels).page(params[:page]).per(100)
  end

  private

    def series_params
      params.require(:novel_series).permit(:title, :outline, :thumbnail, :genre_id)
    end
end

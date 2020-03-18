module Search
  class ComicSeries
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      comic_series = ::ComicSeries.includes(:user, :comics)
      comic_series = comic_series.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      comic_series = comic_series.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return comic_series
    end

  end
end
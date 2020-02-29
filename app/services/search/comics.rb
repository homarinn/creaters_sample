module Search
  class Comics
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      comic_series = search_comic_series
      comics       = search_short_comics
      return comic_series, comics
    end

    def search_comic_series
      comic_series = ComicSeries.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      comic_series = ComicSeries.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return comic_series
    end

    def search_short_comics
      comics = Comic.where(comic_series_id: nil)
      comics = Comic.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      comics = Comic.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return comics
    end
  end
end
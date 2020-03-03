module Search
  class Comics
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      comics = Comic.where(comic_series_id: nil)
      comics = Comic.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      comics = Comic.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return comics
    end
  end
end
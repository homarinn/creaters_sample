module Search
  class Comics
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      comics = Comic.includes(:user).public_posted
      comics = comics.short_stories
      comics = comics.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      comics = comics.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return comics
    end
  end
end
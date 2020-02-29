module Search
  class Novels
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      novel_series = search_novel_series
      novels       = search_short_novels
      return novel_series, novels
    end

    def search_novel_series
      novel_series = NovelSeries.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novel_series = NovelSeries.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novel_series
    end

    def search_short_novels
      novels = Novel.where(novel_series_id: nil)
      novels = Novel.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novels = Novel.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novels
    end

  end
end
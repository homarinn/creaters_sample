module Search
  class Novels
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      novels = Novel.where(novel_series_id: nil)
      novels = Novel.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novels = Novel.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novels
    end

  end
end
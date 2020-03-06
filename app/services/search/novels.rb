module Search
  class Novels
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      novels = Novel.includes(:users)
      novels = novels.where(novel_series_id: nil)
      novels = novels.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novels = novels.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novels
    end

  end
end
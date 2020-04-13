module Search
  class NovelSeries
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      novel_series = ::NovelSeries.includes(:user, :novels).public_posted.has_works
      novel_series = novel_series.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novel_series = novel_series.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novel_series
    end

  end
end
module Search
  class IllustrationSeries
    include Service

    IllustrationSeries = ::IllustrationSeries

    def initialize(params={})
      @params = params
    end

    def run
      illustration_series = ::IllustrationSeries.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustration_series
    end

  end
end
module Search
  class IllustrationSeries
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      illustration_series = ::IllustrationSeries.includes(:user, :illustrations).public_posted.has_works
      illustration_series = illustration_series.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustration_series
    end

  end
end
module Search
  class Illustrations
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      illustration_series = search_illustration_series
      illustrations       = search_short_illustrations
      return illustration_series, illustrations
    end

    def search_illustration_series
      illustration_series = IllustrationSeries.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustration_series
    end

    def search_short_illustrations
      illustrations = Illustration.where(illustration_series_id: nil)
      illustrations = Illustration.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustrations
    end
  end
end
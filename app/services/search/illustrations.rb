module Search
  class Illustrations
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      illustrations = Illustration.includes(:users)
      illustrations = illustrations.where(illustration_series_id: nil)
      illustrations = illustrations.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustrations
    end
  end
end
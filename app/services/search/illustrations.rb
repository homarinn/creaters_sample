module Search
  class Illustrations
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      illustrations = Illustration.includes(:user).public_posted
      illustrations = illustrations.single_illustrations
      illustrations = illustrations.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      return illustrations
    end
  end
end
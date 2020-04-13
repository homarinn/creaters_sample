class IllustrationsController < ApplicationController
  before_action :set_illustration, only: :show

  def index
    @illustrations = Search::Illustrations.run(simple_search_params).order(updated_at: :desc).page(params[:page]).per(100)
  end

  def show
  end

  private

    def set_illustration
      @illustration = Illustration.find(params[:id])
    end

    def simple_search_params
      params.permit(:keyword)
    end
end

class ComicsController < ApplicationController
  before_action :set_comic, only: :show

  def index
    @comics = Search::Comics.run(simple_search_params).order(updated_at: :desc).page(params[:page]).per(100)
  end

  def show
  end

  private

    def set_comic
      @comic = Comic.find(params[:id])
    end

    def simple_search_params
      params.permit(:keyword)
    end
end

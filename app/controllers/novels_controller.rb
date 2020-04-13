class NovelsController < ApplicationController
  before_action :set_novel, only: :show

  def index
    @novels = Search::Novels.run(simple_search_params).order(updated_at: :desc).page(params[:page]).per(100)
  end

  def show
  end

  private

    def set_novel
      @novel = Novel.find(params[:id])
    end

    def simple_search_params
      params.permit(:keyword)
    end
end

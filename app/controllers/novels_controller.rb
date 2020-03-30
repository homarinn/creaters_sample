class NovelsController < ApplicationController
  before_action :set_novel, only: :show

  def index
    @novels = Novel.includes(:user).public_posted.short_stories
  end

  def show
  end

  private

    def set_novel
      @novel = Novel.find(params[:id])
    end
end

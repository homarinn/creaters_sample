class ComicsController < ApplicationController
  before_action :set_comic, only: :show

  def index
    @comics = Comic.includes(:user).public_posted.short_stories
  end

  def show
  end

  private

    def set_comic
      @comic = Comic.find(params[:id])
    end
end

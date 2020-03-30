class Manage::ComicsController < ApplicationController
  before_action :authenticate_user!

  def draft_index
    @comics = current_user.comics.draft
  end

  def draft_show
    @comic = current_user.comics.draft.find_by(id: params[:id])
    check_comic_and_comic_user_is_current_user
  end

  def posted_index
    comics_array = current_user.comics.posted.short_stories + current_user.comic_series
    @comics = comics_array.sort_by(&:updated_at)
  end

  def posted_comic_show
    @comic = current_user.comics.posted.find_by(id: params[:id])
    check_comic_and_comic_user_is_current_user
  end

  def posted_comic_series_show
    @comic_series = current_user.comic_series.find_by(id: params[:id])
    check_comic_series_user_is_current_user
  end

  private

    def check_comic_and_comic_user_is_current_user
      redirect_to root_url, alert: '存在しないページです' unless @comic
    end

    def check_comic_series_user_is_current_user
      redirect_to root_url, alert: '存在しないページです' unless @comic_series
    end
end
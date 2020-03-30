class Manage::IllustrationsController < ApplicationController
  before_action :authenticate_user!

  def draft_index
    @illustrations = current_user.illustrations.draft
  end

  def draft_show
    @illustration = current_user.illustrations.draft.find_by(id: params[:id])
    check_illustration_and_illustration_user_is_current_user
  end

  def posted_index
    illustrations_array = current_user.illustrations.posted.singles + current_user.illustration_series
    @illustrations = illustrations_array.sort_by(&:updated_at)
  end

  def posted_illustration_show
    @illustration = current_user.illustrations.posted.find_by(id: params[:id])
    check_illustration_and_illustration_user_is_current_user
  end

  def posted_illustration_series_show
    @illustration_series = current_user.illustration_series.find_by(id: params[:id])
    check_illustration_series_user_is_current_user
  end

  private

    def check_illustration_and_illustration_user_is_current_user
      redirect_to root_url, alert: '存在しないページです' unless @illustration
    end

    def check_illustration_series_user_is_current_user
      redirect_to root_url, alert: '存在しないページです' unless @illustration_series
    end
end
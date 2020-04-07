class Manage::ComicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comic, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_comic_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def draft_index
    @comics = current_user.comics.draft
  end

  def posted_index
    comics_array = current_user.comics.posted.short_stories + current_user.comic_series
    @comics = comics_array.sort_by(&:updated_at)
  end

  def show
  end

  def new
    @comic = current_user.comics.build
  end

  def create
    @comic = current_user.comics.build(comic_params)
    if @comic.save
      redirect_to manage_comic_path(@comic), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @comic.update(comic_params)
      redirect_to manage_comic_path(@comic), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    index_path = @comic.draft? ? draft_manage_comics_path : posted_manage_comics_path
    to = @comic.series_episode? ? manage_comic_series_path(@comic.comic_series) : index_path
    @comic.destroy
    redirect_to to, notice: flash_message(success: true)
  end

  def post
    redirect_to root_url, alert: "その漫画は既に投稿されています" if @comic.posted?
    return if request.get?

    if @comic.update(post_params)
      to = @comic.series_episode? ? manage_comic_series_path(@comic.comic_series) : manage_comic_path(@comic)
      @comic.comic_series.update_columns(comic_series_params_when_comic_post) if @comic.comic_series
      redirect_to to, notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  private

    def set_comic
      @comic = current_user.comics.find_by(id: params[:id])
    end

    def check_comic_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @comic
    end

    def comic_params
      params.require(:comic).permit(:title, images: [])
    end

    def post_params
      if params[:comic][:comic_series_id].present?
        params.require(:comic).permit(:title, :author_comment, :comic_series_id).merge(status: current_user.comic_series.find(params[:comic][:comic_series_id]).status, posted_at: Time.current)
      else
        params.require(:comic).permit(:title, :outline, :status, :author_comment, :genre_id).merge(posted_at: Time.current)
      end
    end

    def comic_series_params_when_comic_post
      @comic.comic_series.posted_at ? { updated_at: Time.current } : { posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'update' then '更新'
      when 'destroy' then '削除'
      when 'post' then '投稿'
      end
      success ? "漫画を#{action}しました" : "漫画の#{action}に失敗しました"
    end
end
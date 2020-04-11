class Manage::Series::ComicSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comic_series, except: [:new, :create]
  before_action :check_comic_series_user_is_current_user, except: [:new, :create]

  def show
    @comics = @comic_series.comics.page(params[:page]).per(100)
  end

  def new
    @comic_series = current_user.comic_series.build
  end

  def create
    @comic_series = current_user.comic_series.build(comic_series_params)
    if @comic_series.save
      redirect_to manage_comic_series_path(@comic_series), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @comic_series.update(comic_series_params)
      redirect_to manage_comic_series_path(@comic_series), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @comic_series.destroy
    redirect_to posted_manage_comics_path, alert: flash_message(success: true)
  end

  def next_work_post
    return if request.get?

    comic = current_user.comics.find(params[:comic_id])
    if comic.update(next_work_post_params)
      @comic_series.update_columns(comic_series_params_when_comic_post)
      redirect_to manage_comic_series_path(@comic_series), notice: next_work_post_flash_message(success: true)
    else
      flash.now[:alert] = next_work_post_flash_message(success: false)
      render :next_work_post
    end
  end

  def status_change
    after_status = @comic_series.public_posted? ? "private_posted" : "public_posted"
    @comic_series.update_column(:status, after_status)
    @flash_message = @comic_series.public_posted? ? "公開しました" : "非公開にしました"
  end

  private

    def set_comic_series
      @comic_series = current_user.comic_series.find_by(id: params[:id])
    end

    def check_comic_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @comic_series
    end

    def comic_series_params
      params.require(:comic_series).permit(:title, :outline, :genre_id, :thumbnail)
    end

    def next_work_post_params
      params.permit(:author_comment).merge(comic_series_id: @comic_series.id, status: @comic_series.status, posted_at: Time.current)
    end

    def comic_series_params_when_comic_post
      @comic_series.posted_at ? { updated_at: Time.current } : { posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      end
      success ? "連載漫画を#{action}しました" : "連載漫画の#{action}に失敗しました"
    end

    def next_work_post_flash_message(success: )
      success ? "最新話を投稿しました" : "最新話の投稿に失敗しました"
    end
end
class Manage::Series::NovelSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_novel_series, except: [:new, :create]
  before_action :check_novel_series_user_is_current_user, except: [:new, :create]

  def show
    @novels = @novel_series.novels.page(params[:page]).per(100)
  end

  def new
    @novel_series = current_user.novel_series.build
  end

  def create
    @novel_series = current_user.novel_series.build(novel_series_params)
    if @novel_series.save
      redirect_to manage_novel_series_path(@novel_series), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @novel_series.update(novel_series_params)
      redirect_to manage_novel_series_path(@novel_series), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @novel_series.destroy
    redirect_to posted_manage_novels_path, alert: flash_message(success: true)
  end

  def next_work_post
    return if request.get?

    novel = current_user.novels.find(params[:novel_id])
    if novel.update(next_work_post_params)
      @novel_series.update_columns(novel_series_params_when_novel_post)
      redirect_to manage_novel_series_path(@novel_series), notice: next_work_post_flash_message(success: true)
    else
      flash.now[:alert] = next_work_post_flash_message(success: false)
      render :next_work_post
    end
  end

  def status_change
    after_status = @novel_series.public_posted? ? "private_posted" : "public_posted"
    @novel_series.update_column(:status, after_status)
    @flash_message = @novel_series.public_posted? ? "公開しました" : "非公開にしました"
  end

  private

    def set_novel_series
      @novel_series = current_user.novel_series.find_by(id: params[:id])
    end

    def check_novel_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @novel_series
    end

    def novel_series_params
      params.require(:novel_series).permit(:title, :outline, :genre_id, :thumbnail)
    end

    def next_work_post_params
      params.permit(:preface, :postscript).merge(novel_series_id: @novel_series.id, status: @novel_series.status, posted_at: Time.current)
    end

    def novel_series_params_when_novel_post
      @novel_series.posted_at ? { works_count: @novel_series.works_count+1, updated_at: Time.current } : { works_count: @novel_series.works_count+1, posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      when 'next_work_post_params' then '投稿'
      end
      success ? "連載小説を#{action}しました" : "連載小説の#{action}に失敗しました"
    end

    def next_work_post_flash_message(success: )
      success ? "最新話を投稿しました" : "最新話の投稿に失敗しました"
    end
end
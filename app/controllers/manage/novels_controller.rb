class Manage::NovelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_novel, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_novel_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def draft_index
    @novels = current_user.novels.draft
  end

  def posted_index
    novels_array = current_user.novels.posted.short_stories + current_user.novel_series
    @novels = novels_array.sort_by(&:updated_at)
  end

  def show
  end

  def new
    @novel = current_user.novels.build
  end

  def create
    @novel = current_user.novels.build(novel_params)
    if @novel.save
      redirect_to manage_novel_path(@novel), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @novel.update(novel_params)
      redirect_to manage_novel_path(@novel), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    index_path = @novel.draft? ? draft_manage_novels_path : posted_manage_novels_path
    to = @novel.series_episode? ? manage_novel_series_path(@novel.novel_series) : index_path
    @novel.destroy
    redirect_to to, notice: flash_message(success: true)
  end

  def post
    redirect_to root_url, alert: "その小説は既に投稿されています" if @novel.posted?
    return if request.get?

    if @novel.update(post_params)
      to = @novel.series_episode? ? manage_novel_series_path(@novel.novel_series) : manage_novel_path(@novel)
      @novel.novel_series.update_columns(novel_series_params_when_novel_post) if @novel.novel_series
      redirect_to to, notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  private

    def set_novel
      @novel = current_user.novels.find_by(id: params[:id])
    end

    def check_novel_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @novel
    end

    def novel_params
      params.require(:novel).permit(:title, :content)
    end

    def post_params
      if params[:novel][:novel_series_id].present?
        params.require(:novel).permit(:title, :preface, :postscript, :novel_series_id).merge(status: current_user.novel_series.find(params[:novel][:novel_series_id]).status, posted_at: Time.current)
      else
        params.require(:novel).permit(:title, :outline, :status, :preface, :postscript, :genre_id).merge(posted_at: Time.current)
      end
    end

    def novel_series_params_when_novel_post
      @novel.novel_series.posted_at ? { updated_at: Time.current } : { posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'update' then '更新'
      when 'destroy' then '削除'
      when 'post' then '投稿'
      end
      success ? "小説を#{action}しました" : "小説の#{action}に失敗しました"
    end
end
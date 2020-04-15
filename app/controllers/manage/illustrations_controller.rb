class Manage::IllustrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_illustration, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_illustration_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def draft_index
    @illustrations = current_user.illustrations.draft
  end

  def posted_index
    illustrations_array = current_user.illustrations.posted.single_illustrations + current_user.illustration_series
    @illustrations = illustrations_array.sort_by(&:updated_at)
  end

  def show
  end

  def new
    @illustration = current_user.illustrations.build
  end

  def create
    @illustration = current_user.illustrations.build(illustration_params)
    if @illustration.save
      redirect_to manage_illustration_path(@illustration), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @illustration.update(illustration_params)
      redirect_to manage_illustration_path(@illustration), notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @illustration_series = @illustration.illustration_series
    index_path = @illustration.draft? ? draft_manage_illustrations_path : posted_manage_illustrations_path
    to = @illustration.series_illustration? ? manage_illustration_series_path(@illustration_series) : index_path
    @illustration.destroy
    @illustration_series.update_column(:works_count, @illustration_series.works_count-1) if @illustration_series
    redirect_to to, notice: flash_message(success: true)
  end

  def post
    redirect_to root_url, alert: "そのイラストは既に投稿されています" if @illustration.posted?
    return if request.get?

    if @illustration.update(post_params)
      @illustration_series = @illustration.illustration_series
      to = @illustration.series_illustration? ? manage_illustration_series_path(@illustration_series) : manage_illustration_path(@illustration)
      @illustration_series.update_columns(illustration_series_params_when_illustration_post) if @illustration.series_illustration?
      redirect_to to, notice: flash_message(success: true)
    else
      flash.now[:alert] = flash_message(success: false)
      render :post
    end
  end

  private

    def set_illustration
      @illustration = current_user.illustrations.find_by(id: params[:id])
    end

    def check_illustration_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @illustration
    end

    def illustration_params
      params.require(:illustration).permit(:title, :image)
    end

    def post_params
      if params[:illustration][:illustration_series_id].present?
        params.require(:illustration).permit(:title, :author_comment, :illustration_series_id).merge(status: current_user.illustration_series.find(params[:illustration][:illustration_series_id]).status, posted_at: Time.current)
      else
        params.require(:illustration).permit(:title, :status, :author_comment).merge(posted_at: Time.current)
      end
    end

    def illustration_series_params_when_illustration_post
      @illustration_series.posted_at ? { works_count: @illustration_series.works_count+1, updated_at: Time.current } : {works_count: @illustration_series.works_count+1, posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'update' then '更新'
      when 'destroy' then '削除'
      when 'post' then '投稿'
      end
      success ? "イラストを#{action}しました" : "イラストの#{action}に失敗しました"
    end
end
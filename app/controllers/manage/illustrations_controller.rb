class Manage::IllustrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_illustration, only: [:show, :edit, :update, :destroy, :post]
  before_action :check_illustration_user_is_current_user, only: [:show, :edit, :update, :destroy, :post]

  def draft_index
    @illustrations = current_user.illustrations.draft
  end

  def posted_index
    illustrations_array = current_user.illustrations.posted.short_stories + current_user.illustration_series
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
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @illustration.update(illustration_params)
      redirect_to manage_illustration_path(@illustration), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    index_path = @illustration.draft? ? draft_manage_illustrations_path : posted_manage_illustrations_path
    to = @illustration.series_episode? ? manage_illustration_series_path(@illustration.illustration_series) : index_path
    @illustration.destroy
    redirect_to to, notice: flash_message(success: true)
  end

  def post
    redirect_to root_url, alert: "その小説は既に投稿されています" if @illustration.posted?
    return if request.get?

    if @illustration.update(post_params)
      to = @illustration.series_episode? ? manage_illustration_series_path(@illustration.illustration_series) : manage_illustration_path(@illustration)
      redirect_to to, notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
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
      params.require(:illustration).permit(:title, :content)
    end

    def post_params
      if params[:illustration][:illustration_series_id].present?
        params[:illustration][:illustration_series_id] = params[:illustration][:illustration_series_id].to_i
        params.require(:illustration).permit(:title, :author_comment, :illustration_series_id).merge(status: current_user.illustration_series.find(params[:illustration][:illustration_series_id]).status)
      else
        params.require(:illustration).permit(:title, :status, :author_comment)
      end
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
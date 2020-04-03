class Manage::Series::IllustrationSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_illustration_series, except: [:new, :create]
  before_action :check_illustration_series_user_is_current_user, except: [:new, :create]

  def show
    @illustrations = @illustration_series.illustrations.page(params[:page]).per(100)
  end

  def new
    @illustration_series = current_user.illustration_series.build
  end

  def create
    @illustration_series = current_user.illustration_series.build(illustration_series_params)
    if @illustration_series.save
      redirect_to manage_illustration_series_path(@illustration_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :new
    end
  end

  def edit
  end

  def update
    if @illustration_series.update(illustration_series_params)
      redirect_to manage_illustration_series_path(@illustration_series), notice: flash_message(success: true)
    else
      flash.now[:error] = flash_message(success: false)
      render :edit
    end
  end

  def destroy
    @illustration_series.destroy
    redirect_to posted_manage_illustrations_path, alert: flash_message(success: true)
  end

  def next_work_post
    return if request.get?

    illustration = current_user.illustrations.find(params[:illustration_series][:illustration_id])
    if illustration.update(next_work_post_params)
      @illustration_series.update_columns(illustration_series_params_when_illustration_post)
      redirect_to manage_illustration_series_path(@illustration_series), notice: next_work_post_flash_message(success: true)
    else
      flash.now[:error] = next_work_post_flash_message(success: false)
      render :next_work_post
    end
  end

  def status_change
    after_status = @illustration_series.public_posted? ? "private_posted" : "public_posted"
    @illustration_series.update_column(:status, after_status)
    @flash_message = @illustration_series.public_posted? ? "公開しました" : "非公開にしました"
  end

  private

    def set_illustration_series
      @illustration_series = current_user.illustration_series.find_by(id: params[:id])
    end

    def check_illustration_series_user_is_current_user
      redirect_to root_url, alert: '存在しない、もしくはあなたに操作権限のないページです' unless @illustration_series
    end

    def illustration_series_params
      params.require(:illustration_series).permit(:title, :outline, :thumbnail)
    end

    def next_work_post_params
      params.permit(:author_comment).merge(illustration_series_id: @illustration_series.id, status: @illustration_series.status, posted_at: Time.current)
    end

    def illustration_series_params_when_illustration_post
      @illustration_series.posted_at ? { updated_at: Time.current } : { posted_at: Time.current, updated_at: Time.current }
    end

    def flash_message(success: )
      action = case params[:action]
      when 'create' then '作成'
      when 'edit' then '編集'
      when 'destroy' then '削除'
      end
      success ? "イラスト集を#{action}しました" : "イラスト集の#{action}に失敗しました"
    end

    def next_work_post_flash_message(success: )
      success ? "最新イラストを投稿しました" : "最新イラストの投稿に失敗しました"
    end
end
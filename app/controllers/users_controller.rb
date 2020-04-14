class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.order(updated_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to manage_mypage_path, notice: 'ユーザーの情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー登録に失敗しました'
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:nickname, :profile, :icon)
    end
end

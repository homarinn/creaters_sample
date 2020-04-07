class IllustrationsController < ApplicationController
  before_action :set_illustration, only: :show

  def index
    @illustrations = Illustration.includes(:user).public_posted.single_illustrations
  end

  def show
  end

  private

    def set_illustration
      @illustration = Illustration.find(params[:id])
    end
end

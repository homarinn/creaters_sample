class Series::IllustrationSeriesController < ApplicationController
  def index
    @illustration_series_index = IllustrationSeries.all.order(updated_at: :desc)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

module Search
  class Novels
    include Service

    def initialize(params={})
      @params = params
    end

    def run
      novels = Novel.includes(:user)
      novels = novels.short_stories
      novels = novels.where('title like ?', "%#{@params[:keyword]}%") if @params[:keyword].present?
      novels = novels.where(genre_id: @params[:genre_id]) if @params[:genre_id].present?
      return novels
    end

  end
end
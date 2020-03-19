class Series < ApplicationRecord
  has_one_attached :thumbnail

  belongs_to :user

  scope :new_posted_list, -> (limit: 1000) {
    includes(:user).order(updated_at: :desc).limit(limit)
  }

  def is_novel_series?
    self.type == "NovelSeries"
  end

  def is_illustration_series?
    self.type == "IllustrationSeries"
  end

  def is_comic_series?
    self.type == "ComicSeries"
  end
end

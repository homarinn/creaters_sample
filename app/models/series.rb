class Series < ApplicationRecord
  has_one_attached :thumbnail

  belongs_to :user

  enum status: {public_posted: 0, private_posted: 1}

  scope :new_posted_list, -> (limit: 1000) {
    order(updated_at: :desc).limit(limit)
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

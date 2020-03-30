class Comic < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  has_many_attached :images

  belongs_to :comic_series, optional: true

  validates_with ComicValidator

  scope :short_stories, -> {
    where(comic_series_id: nil)
  }

  def series_episode?
    self.comic_series_id.present?
  end

  def short_story?
    self.comic_series_id.blank? && self.posted?
  end
end

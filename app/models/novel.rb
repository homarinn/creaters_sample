class Novel < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  belongs_to :novel_series, optional: true

  validates_with NovelValidator

  scope :short_stories, -> {
    where(novel_series_id: nil)
  }

  scope :series_episodes, -> {
    where.not(novel_series_id: nil)
  }

  def words_count
    self.content.length
  end

  def series_episode?
    self.novel_series_id.present?
  end

  def short_story?
    self.novel_series_id.blank? && self.posted?
  end
end

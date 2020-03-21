class Novel < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  belongs_to :novel_series, optional: true

  enum status: {is_draft: 0, is_public: 1, is_private: 2}

  validates_with NovelValidator

  def words_count
    self.content.length
  end

  def series_story?
    self.novel_series_id.present?
  end
end

class Novel < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  belongs_to :novel_series, optional: true

  validates_with NovelValidator

  def words_count
    self.content.length
  end
end

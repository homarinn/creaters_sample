class Novel < ApplicationRecord
  include Work
  include BelongsToGenre

  has_rich_text :content

  belongs_to :novel_series, optional: true

  validates_with NovelValidator
end

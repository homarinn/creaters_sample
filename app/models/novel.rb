class Novel < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  has_one_attached :thumbnail

  belongs_to :novel_series, optional: true

  validates_with NovelValidator
end

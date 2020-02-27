class Comic < ApplicationRecord
  include Work
  include BelongsToGenre

  has_one_attached :thumbnail
  has_many_attached :images

  belongs_to :comic_series, optional: true

  validates_with ComicValidator
end

class Comic < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  has_many_attached :images

  belongs_to :comic_series, optional: true

  validates_with ComicValidator
end

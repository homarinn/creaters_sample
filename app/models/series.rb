class Series < ApplicationRecord
  HAS_THUMBNAIL_MODELS = %w(IllustrationSeries ComicSeries)

  belongs_to :user
end

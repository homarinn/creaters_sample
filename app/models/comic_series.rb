class ComicSeries < Series
  include BelongsToGenre

  has_many :comics, dependent: :destroy
  has_one_attached :thumbnail
end
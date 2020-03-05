class ComicSeries < Series
  include BelongsToGenre

  has_many :comics, dependent: :destroy

  validates_with Series::ComicSeriesValidator
end
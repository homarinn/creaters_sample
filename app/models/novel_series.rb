class NovelSeries < Series
  has_many :novels, dependent: :destroy

  include BelongsToGenre

  validates_with Series::NovelSeriesValidator
end
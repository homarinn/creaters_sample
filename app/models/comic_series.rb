class ComicSeries < Series
  include BelongsToGenre

  has_many :comics, dependent: :destroy

  validates_with Series::ComicSeriesValidator

  def works_count
    self.comics.size
  end

  def works_unit
    "話"
  end
end
class NovelSeries < Series
  has_many :novels, dependent: :destroy

  include BelongsToGenre

  validates_with Series::NovelSeriesValidator

  def words_count
    self.novels.map(&:content).join.length
  end

  def works_unit
    "話"
  end
end
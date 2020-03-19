class IllustrationSeries < Series
  has_many :illustrations, dependent: :destroy

  validates_with Series::IllustrationSeriesValidator

  def works_count
    self.illustrations.size
  end
end
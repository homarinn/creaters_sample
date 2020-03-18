class IllustrationSeries < Series
  has_many :illustrations, dependent: :destroy

  validates_with Series::IllustrationSeriesValidator

  def illustrations_count
    self.illustrations.size
  end
end
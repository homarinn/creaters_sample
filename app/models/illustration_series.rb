class IllustrationSeries < Series
  has_many :illustrations, dependent: :destroy

  validates_with Series::IllustrationSeriesValidator
end
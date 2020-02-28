class IllustrationSeries < Series
  has_many :illustrations, dependent: :destroy
  has_one_attached :thumbnail

  validates_with Series::IllustrationSeriesValidator
end
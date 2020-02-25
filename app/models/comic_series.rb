class ComicSeries < Series
  has_many :comics, dependent: :destroy
  has_one_attached :thumbnail
end
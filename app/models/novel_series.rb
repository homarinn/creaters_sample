class NovelSeries < Series
  has_many :novels, dependent: :destroy

  include BelongsToGenre
end
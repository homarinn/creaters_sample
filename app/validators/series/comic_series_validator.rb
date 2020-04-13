class Series::ComicSeriesValidator < DefaultValidator
  include SeriesValidator

  def genre_id_validate(genre_id)
    return "ジャンルを選択してください" if genre_id.blank?
  end
end
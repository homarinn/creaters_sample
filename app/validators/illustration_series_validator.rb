class IllustrationSeriesValidator < SeriesValidator
  def thumbnail_validator(thumbnail)
    return "サムネイルを選択してください" if thumbnail.blank?
    return "非対応の拡張子です(png, jpg, jpegに対応しています)" if thumbnail.attached? && !thumbnail.content_type.in?(IMAGE_EXTENSIONS)
  end
end
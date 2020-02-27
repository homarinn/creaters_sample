class ComicValidator < DefaultValidator
  def title_validate(record)
    return "タイトルを入力してください" if title.blank?
    return "100文字以下で入力してください" if title.length > 100
  end

  def image_validate(image)
    return "投稿するイラストを選択してください"　if image.blank?
    return "非対応の拡張子です(png, jpg, jpegに対応しています)" if image.attached? && !image.content_type.in?(IMAGE_EXTENSIONS)
  end

  def thumbnail_validate(thumbnail)
    return "サムネイルを選択してください"　if thumbnail.blank?
    return "非対応の拡張子です(png, jpg, jpegに対応しています)" if thumbnail.attached? && !thumbnail.content_type.in?(IMAGE_EXTENSIONS)
  end
end
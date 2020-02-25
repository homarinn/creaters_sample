class ComicValidator < DefaultValidator
  def title_validate(record)
    if @title.blank?
      record.errors[:title] << "タイトルを入力してください"
    elsif 100 < @title.length
      record.errors[:title] << "100文字以下で入力してください"
    end
  end

  def image_validate(record)
    record.errors[:image] << "投稿するイラストを選択してください"　if @image.blank?
    record.errors[:image] << "非対応の拡張子です(png, jpg, jpegに対応しています)" if @image.attached? !@image.content_type.in?(IMAGE_EXTENSIONS)
  end

  def thumbnail_validate(record)
    record.errors[:thumbnail] << "サムネイルを選択してください"　if @thumbnail.blank?
    record.errors[:thumbnail] << "非対応の拡張子です(png, jpg, jpegに対応しています)" if @thumbnail.attached? && !@thumbnail.content_type.in?(IMAGE_EXTENSIONS)
  end
end
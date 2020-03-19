class ComicValidator < DefaultValidator
  def title_validate(title)
    return "タイトルを入力してください" if title.blank?
    return "100文字以下で入力してください" if title.length > 100
  end

  def author_comment_validate(author_comment)
    return if author_comment.blank?
    return "5000文字以下で入力してください" if author_comment.length > 5000
  end

  def images_validate(images)
    return "投稿するイラストを選択してください" if images.blank?
    return "非対応の拡張子の画像が含まれています(png, jpg, jpegに対応しています)" if images.all?{|image| image.attached? && !image.content_type.in?(IMAGE_EXTENSIONS)}
  end

  def genre_id_validate(genre_id)
    return if @record.comic_series_id.blank?
    return "ジャンルを選択してください" if genre_id.blank?
  end
end
class IllustrationValidator < DefaultValidator
  def title_validate(title)
    return "タイトルを入力してください" if title.blank?
    return "100文字以下で入力してください" if title.length > 100
  end

  def author_comment_validate(author_comment)
    return if author_comment.blank?
    return "5000文字以下で入力してください" if author_comment.length > 5000
  end

  def image_validate(image)
    return "投稿するイラストを選択してください" if image.blank?
    return "非対応の拡張子です(png, jpg, jpegに対応しています)" if image.attached? && !image.content_type.in?(IMAGE_EXTENSIONS)
  end
end
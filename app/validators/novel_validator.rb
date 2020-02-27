class NovelValidator < DefaultValidator
  def title_validate(title)
    return "タイトルを入力してください" if title.blank?
    return "100文字以下で入力してください" if title.length > 100
  end

  def content_validate(content)
    return "本文を入力してください" if content.blank?
  end
end
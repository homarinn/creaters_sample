class NovelValidator < DefaultValidator
  def title_validate(title)
    return "タイトルを入力してください" if title.blank?
    return "100文字以下で入力してください" if title.length > 100
  end

  def content_validate(content)
    return "本文を入力してください" if content.blank?
  end

  def preface_validate(preface)
    return "3000文字以下で入力してください" if preface.length > 3000
  end

  def postscript_validate(postscript)
    return "3000文字以下で入力してください" if postscript.length > 3000
  end

  def genre_id_validate(genre_id)
    return "ジャンルを選択してください" if genre_id.blank?
  end
end
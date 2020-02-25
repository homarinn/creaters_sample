class NovelValidator < DefaultValidator
  def title_validate(record)
    if @title.blank?
      record.errors[:title] << "タイトルを入力してください"
    elsif 100 < @title.length
      record.errors[:title] << "100文字以下で入力してください"
    end
  end

  def content_validate(record)
    record.errors[:content] << "本文を入力してください" if @content.blank?
  end
end
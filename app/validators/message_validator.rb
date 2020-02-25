class MessageValidator < DefaultValidator
  def content_validate(record)
    if @content.blank?
      record.errors[:content] << "本文を入力してください"
    elsif 5000 < @content.length
      record.errors[:content] << "5000文字以下で入力してください"
    end
  end
end
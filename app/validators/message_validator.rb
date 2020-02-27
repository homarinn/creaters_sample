class MessageValidator < DefaultValidator
  def content_validate(content)
    return "タイトルを入力してください" if content.blank?
    return "5000文字以下で入力してください" if content.length > 5000
  end
end
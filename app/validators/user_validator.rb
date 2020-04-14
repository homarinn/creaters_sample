class UserValidator < DefaultValidator
  def nickname_validate(nickname)
    return "ニックネームを入力してください" if nickname.blank?
    return "20文字以下で入力してください" if nickname.length > 20
  end

  def profile_validate(profile)
    return if profile.blank?
    return "プロフィールは10000文字以内で入力してください" if profile.length > 10000
  end

  def email_validate(email)
    return "メールアドレスを入力してください" if email.blank?
    return "有効なメールアドレスを入力してください" if !email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def password_validate(password)
    return if password.blank? && @record.encrypted_password.present?
    return "パスワードを入力してください" if password.blank?
    return "パスワードは7文字以上128文字以内で設定してください" if password.length < 7 || password.length > 128
    return "半角英字と半角数字を含むパスワードを設定してください" if !password.match?(/\A(?=.*?[a-z])(?=.*?\d).+\z/i)
  end

  def password_confirmation_validate(password_confirmation)
    return if password_confirmation.blank? && @record.encrypted_password.present?
    return "確認用パスワードを入力してください" if password_confirmation.blank?
    return "パスワードと確認用パスワードが違います" if password_confirmation != @record.password
  end
end
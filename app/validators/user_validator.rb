# ================================================================================
# ※応急処置
# emailとpasswordのerror_messageは、deviseのerror_messageが邪魔なのでshiftで削除している
# ================================================================================

class UserValidator < DefaultValidator
  def nickname_validate(nickname)
    return "ニックネームを入力してください" if nickname.blank?
    return "20文字以下で入力してください" if nickname.length > 20
  end

  def password_validate(password)
    return "半角英字と半角数字を含むパスワードを設定してください" if !password.match?(/\A(?=.*?[a-z])(?=.*?\d).+\z/i)
  end

  def password_confirmation_validate(password_confirmation)
    return "パスワード (確認) を入力してください" if password_confirmation.blank?
  end
end
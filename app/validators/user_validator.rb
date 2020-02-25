# ================================================================================
# ※応急処置
# emailとpasswordのerror_messageは、deviseのerror_messageが邪魔なのでshiftで削除している
# ================================================================================

class UserValidator < DefaultValidator
  def nickname_validate(record)
    if @nickname.blank?
      record.errors[:nickname] << "ニックネームを入力してください"
    elsif 20 < @nickname.length
      record.errors[:nickname] << "20文字以下で入力してください"
    end
  end

  def email_validate(record)
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    if @email.blank?
      record.errors[:email].push("メールアドレスを入力してください").shift()
    elsif !@email.match?(email_regex)
      record.errors[:email].push("フォーマットが不適切です").shift()
    end
  end

  def password_validate(record)
    password_regex = /\A(?=.*?[a-z])(?=.*?\d).+\z/i
    if @password.blank?
      record.errors[:password].push("パスワードを入力してください").shift()
    elsif @password.length < 7 || 128 < @password.length
      record.errors[:password].push("パスワードは7文字以上128文字以下で入力してください").shift()
    elsif !@password.match?(password_regex)
      record.errors[:password] << "英字と数字両方を含むパスワードを設定してください"
    end
  end

  def password_confirmation_validate(record)
    password_regex = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
    if @password_confirmation.blank?
      record.errors[:password_confirmation] << "パスワード (確認) を入力してください"
    elsif @password_confirmation != @password
      record.errors[:password_confirmation].push("パスワードとパスワード (確認) が一致しません") if @password.present?
      record.errors[:password_confirmation].shift()
    end
  end
end
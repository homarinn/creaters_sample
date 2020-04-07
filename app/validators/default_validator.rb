# =================================================================================================
# 新しいカスタムバリデータはDefaultValidatorを継承
# 各バリデーション用メソッドはpublic下に〇〇_validate(〇〇)と記載(例: nickname_validate(nickname))
# メソッド内では@recordでrecordを参照できる

# カスタムバリデータの作成理由
# モデルの記述量を減らすためにバリデーションの記載は別の所に纏めたかった

# 色々使いやすさを追求して自分なりに作成してみたが駄目な部分も多い(特にデフォルトのエラーメッセージを全て削除している点)
# =================================================================================================

class DefaultValidator < ActiveModel::Validator
  IMAGE_EXTENSIONS = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/bmp']

  # メソッド名を参照にするのが気になるが、
  # 逆に強制的にメソッド名を統一させられること、
  # 他にベストプラクティスが思いつかなかったことから一旦この形
  def validate(record)
    clear_errors(record)
    public_methods(false).each do |method|
      next unless method.match?(/_validate/)
      generate_error(record, method)
    end
  end

  private

    # デフォルトのエラーメッセージを全て削除している
    def clear_errors(record)
      record.errors.details.clear()
      record.errors.messages.clear()
    end

    def generate_error(record, method)
      @record = record # 各バリデーションで使う時用にインスタンス変数に保存
      column_name = method.match(/(.+)_validate/)[1]
      error_message = send(method, eval("record.#{column_name}"))
      record.errors[column_name.to_sym] << error_message if error_message.present?
    end
end
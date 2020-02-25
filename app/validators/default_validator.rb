# ========================================================================================
# 新しいカスタムバリデータはDefaultValidatorを継承
# 各バリデーション用メソッドは〇〇_validate(record)にしてpublic下に(例: nickname_validate(record))
# メソッド内ではインスタンス変数で各カラムを参照できる(例: name→@name)

# カスタムバリデータの作成理由
# モデルの記述量を減らすためにバリデーションの記載は別の所に纏めたかった
# =========================================================================================

class DefaultValidator < ActiveModel::Validator
  IMAGE_EXTENSIONS = ['image/png', 'image/jpg', 'image/jpeg']

  # メソッド名を参照にするのが気になるが
  # 逆に強制的にメソッド名を統一させられること
  # 他にベストプラクティスが思いつかなかったことから一旦この形
  def validate(record)
    public_methods(false).each do |method|
      next unless method.match?(/_validate/)

      extract_column_from_method_name_and_set_instance(method, record)
      send(method, record)
    end
  end

  private

    def extract_column_from_method_name_and_set_instance(method, record)
      column_name = method.match(/(.+)_validate/)[1]
      instance_variable_set("@#{column_name}", eval("record.#{column_name}"))
    end
end
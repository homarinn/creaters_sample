# ================================================
# 各シリーズ固有のバリデーションは各モデルに直接記載している
# ================================================

class SeriesValidator < DefaultValidator
  def title_validate(record)
    if @title.blank?
      record.errors[:title] << "タイトルを入力してください"
    elsif 100 < @title.length
      record.errors[:title] << "100文字以下で入力してください"
    end
  end

  def outline_validate(record)
    record.errors[:title] << "5000文字以下で入力してください" if @outline.present? && @outline.length > 5000
  end
end
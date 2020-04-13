module SeriesValidator
  extend ActiveSupport::Concern

  included do
    def title_validate(title)
      return "タイトルを入力してください" if title.blank?
      return "100文字以下で入力してください" if title.length > 100
    end

    def outline_validate(outline)
      return if outline.blank?
      return "5000文字以下で入力してください" if outline.length > 5000
    end

    def thumbnail_validator(thumbnail)
      return "サムネイルを選択してください" if thumbnail.blank?
      return "非対応の拡張子です(png, jpg, jpegに対応しています)" if thumbnail.attached? && !thumbnail.content_type.in?(IMAGE_EXTENSIONS)
    end
  end
end
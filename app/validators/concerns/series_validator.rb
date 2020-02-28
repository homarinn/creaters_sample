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
  end
end
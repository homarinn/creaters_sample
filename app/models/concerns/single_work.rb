# ==============================================
# 小説、イラスト、漫画など作品に共通する処理はここに纏める
# ==============================================
module SingleWork
  extend ActiveSupport::Concern

  included do
    belongs_to :user

    scope :new_posted_list, -> (limit: 1000) {
      order(updated_at: :desc).limit(limit)
    }

    scope :posted, -> {
      where.not(status: :draft)
    }

    enum status: {draft: 0, public_posted: 1, private_posted: 2}

    def posted?
      !self.draft?
    end
  end
end
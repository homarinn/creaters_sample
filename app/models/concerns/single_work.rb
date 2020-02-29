# ==============================================
# 小説、イラスト、漫画など作品に共通する処理はここに纏める
# ==============================================
module SingleWork
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end
end
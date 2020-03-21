class Illustration < ApplicationRecord
  include SingleWork

  has_one_attached :image

  belongs_to :illustration_series, optional: true

  enum status: {is_draft: 0, is_public: 1, is_private: 2}

  validates_with IllustrationValidator
end

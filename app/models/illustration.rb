class Illustration < ApplicationRecord
  include SingleWork

  has_one_attached :image

  belongs_to :illustration_series, optional: true

  validates_with IllustrationValidator
end

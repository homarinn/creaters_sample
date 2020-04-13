class Illustration < ApplicationRecord
  include SingleWork

  has_one_attached :image

  belongs_to :illustration_series, optional: true

  validates_with IllustrationValidator

  scope :single_illustrations, -> {
    where(illustration_series_id: nil)
  }

  scope :series_episodes, -> {
    where.not(illustration_series_id: nil)
  }

  def series_illustration?
    self.illustration_series_id.present?
  end

  def single_illustration?
    self.illustration_series_id.blank? && self.posted?
  end
end

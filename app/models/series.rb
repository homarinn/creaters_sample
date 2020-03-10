class Series < ApplicationRecord
  has_one_attached :thumbnail

  belongs_to :user

  scope :new_posted_list, -> (limit: 1000) {
    includes(:user).order(updated_at: :desc).limit(limit)
  }
end

class Series < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  validates_with SeriesValidator
end

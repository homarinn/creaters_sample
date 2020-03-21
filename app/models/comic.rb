class Comic < ApplicationRecord
  include SingleWork
  include BelongsToGenre

  has_many_attached :images

  belongs_to :comic_series, optional: true

  enum status: {is_draft: 0, is_public: 1, is_private: 2}

  validates_with ComicValidator
end

module BelongsToGenre
  extend ActiveSupport::Concern

  included do
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :genre
  end
end
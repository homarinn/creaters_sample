class IllustrationSeries < Series
  has_many :illustrations, dependent: :destroy
  has_one_attached :thumbnail

  validates :thumbnail, presence: true
  validate :thumbnail_presence_and_extension, if: :was_attached?

  private

    def thumbnail_presence_and_extension
      errors.add(:thumbnail, "非対応の拡張子です(png, jpg, jpegに対応しています)") unless thumbnail.content_type.in?(DefaultValidator::IMAGE_EXTENSIONS)
    end

    def was_attached?
      self.thumbnail.attached?
    end
end
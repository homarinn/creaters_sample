class Novel < ApplicationRecord
  include Work

  has_rich_text :content

  belongs_to :novel_series, optional: true
end

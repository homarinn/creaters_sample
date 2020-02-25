class Genre < ApplicationRecord
  has_many :series
  has_many :novels
  has_many :illustrations
  has_many :comics
end

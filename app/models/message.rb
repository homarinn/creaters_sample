class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message_room

  validates_with MessageValidator
end

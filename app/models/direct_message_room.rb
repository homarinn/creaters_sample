class DirectMessageRoom < MessageRoom
  validates :user_number

  private

    def user_number
      errors.add(:users, "は2人までです") if users.size > 2
    end
end
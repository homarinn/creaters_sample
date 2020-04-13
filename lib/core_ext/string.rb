class String
  def to_bool
    ActiveRecord::Type::Boolean.new.cast(self)
  end
end
class ScoreCounter
  include ActiveModel::ForbiddenAttributesProtection
  def count_by_day(date)
    @daily_brothers_count = Brother.by_created_day(date).count
    @daily_entry_count = Entry.by_created_day(date).count
    @daily_mitaine_count = Circus.by_created_day(date).count
    self
  end
end

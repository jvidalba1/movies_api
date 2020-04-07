class Reservation < Sequel::Model
  extend Base

  many_to_one :show

  def validate
    super
    errors.add(:date, "can't be empty") if date.blank?
    errors.add(:date, "this movie is full") if self.show.reservations.count > 10
  end

  dataset_module do
    def by_day(day)
      association_join(:days).where(day: day).all
    end
  end
end

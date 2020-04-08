class Reservation < Sequel::Model
  extend Base

  many_to_one :show

  def validate
    super
    errors.add(:date, "can't be empty") if date.blank?
    errors.add(:show_id, "can't be empty") unless show_id

    if show && show.reservations.count > 10
      errors.add(:movie, " cannot accept more reservations.")
    end
  end

  dataset_module do
    def by_date_range(start_date, end_date)
      where(date: (start_date)..(end_date)).all
    end
  end
end

require_relative 'base.rb'

class Day < Sequel::Model
  extend Base

  one_to_many :shows
  many_to_many :movies, join_table: :shows

  def validate
    super
    errors.add(:name, "day can't be empty") if name.blank?
  end
end

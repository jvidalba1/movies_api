class Show < Sequel::Model
  extend Base

  many_to_one :movie
  many_to_one :day

  one_to_many :reservations
end

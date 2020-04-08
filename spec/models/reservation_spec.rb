require 'spec_helper'

describe "Sequel::Reservation" do

  before(:each) do
    @movie = Movie.create(title: "Avatar", description: "Fiction")
    @movie2 = Movie.create(title: "Rambo", description: "Action")

    @monday = Day.create(name: 'monday')
    @friday = Day.create(name: 'friday')

    @movie.add_day(@monday)
    @movie.add_day(@friday)

    @movie2.add_day(@monday)

    @show1 = Show.where(movie_id: @movie.id, day_id: @monday.id).first
    @show2 = Show.where(movie_id: @movie.id, day_id: @friday.id).first
    @show3 = Show.where(movie_id: @movie2.id, day_id: @monday.id).first
  end

  after(:each) do
    Reservation.all.each { |r| r.delete }
    Show.all.each { |s| s.delete }
    Movie.all.each { |m| m.delete }
    Day.all.each { |d| d.delete }
  end

  describe "Validations" do
    it 'returns valid object with all data' do
      reservation = Reservation.new(date: Date.today, show_id: @show1.id)
      expect(reservation.valid?).to eq(true)
    end

    it "returns invalid without date" do
      reservation = Reservation.new(date: nil, show_id: @show1.id)
      expect(reservation.valid?).to eq(false)
    end

    it "returns valid false without show id" do
      reservation = Reservation.new(date: nil, show_id: nil)
      expect(reservation.valid?).to eq(false)
    end

    it "returns invalid for more than 10 reservations" do
      (0..10).each { |n| Reservation.create(date: Date.parse("2020-04-06"), show_id: @show1.id) }

      reservation = Reservation.new(date: Date.parse("2020-04-06"), show_id: @show1.id)
      expect(reservation.valid?).to eq(false)
      expect(reservation.errors[:movie]).to eq([" cannot accept more reservations."])
    end
  end

  describe "dataset" do
    describe("#by_date_range") do
      it 'returns the specific reservations for a date range given' do
        reservation1 = Reservation.create(date: Date.parse("2020-04-06"), show_id: @show1.id)
        reservation2 = Reservation.create(date: Date.parse("2020-04-10"), show_id: @show2.id)
        reservation3 = Reservation.create(date: Date.parse("2020-04-06"), show_id: @show3.id)

        start_date = Date.parse("2020-04-05")
        end_date = Date.parse("2020-04-08")

        expect(Reservation.by_date_range(start_date, end_date)).to eq([reservation1, reservation3])
      end

    end
  end
end


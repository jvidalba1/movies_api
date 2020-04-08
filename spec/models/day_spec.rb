require 'spec_helper'
require_relative '../../app/models/movie.rb'
require_relative '../../app/models/day.rb'
require_relative '../../app/models/base.rb'
require_relative '../../app/models/show.rb'

describe "Sequel::Day" do
  describe "Validations" do
    describe "Name" do
      it "returns valid true with name" do
        day = Day.new(name: "monday")
        expect(day.valid?).to eq(true)
      end

      it "returns valid false without title" do
        day = Day.new(name: "")
        expect(day.valid?).to eq(false)
      end
    end
  end
end


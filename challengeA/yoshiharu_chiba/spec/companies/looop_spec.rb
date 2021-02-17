# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Looop do
  describe 'Looopでんきおうちプランの料金計算' do
    context '10A' do
      it '120kWh' do
        looop = Looop.new(10, 120)
        expect(looop.looop_plan).to eq 3168
      end

      it '301kWh' do
        looop = Looop.new(10, 301)
        expect(looop.looop_plan).to eq 7946
      end
    end

    context '60A' do
      it '120kWh' do
        looop = Looop.new(60, 120)
        expect(looop.looop_plan).to eq 3168
      end

      it '301kWh' do
        looop = Looop.new(60, 301)
        expect(looop.looop_plan).to eq 7946
      end
    end
  end
end

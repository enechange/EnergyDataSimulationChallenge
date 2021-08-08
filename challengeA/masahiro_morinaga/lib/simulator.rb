# pryはpushする時に削除する
require "pry"
require 'active_model'

class Simulator
	include ActiveModel::Model

	def initialize(ampere, monthly_energy)
		@ampere = ampere
		@monthly_energy = monthly_energy
	end

	def simulate
		puts 'hoge'
	end

	def create
		@simulator = Simulator.new
	end

	private

end

user_amps = [10, 15, 20, 30, 40, 50, 60]
puts '契約しているアンペア数を入力してください'
amps = gets.to_i

puts "正しいアンペア数を入力してください" if !user_amps.include?(amps)

if user_amps.include?(amps)
	puts "1ヶ月あたりの使用量(kWh)を入力してください" if user_amps.include?(amps)

	ammount_energy = gets.to_i

	simulator = Simulator.new(amps, ammount_energy)

	simulator.simulate
end



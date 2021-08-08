# pryはpushする時に削除する
require "pry"
# validationかける　→　間に合わなかったら消す
require 'active_model'
require 'yaml'

class Simulator
	include ActiveModel::Model

	def initialize(ampere, monthly_energy)
		@ampere = ampere
		@monthly_energy = monthly_energy
	end

	def simulate

		set_plans()
		
	end

	def create
		@simulator = Simulator.new
	end

	def set_plans
		plans = YAML.load_file('../plan.yml')

		monthly_charge_hash = {
			name: "",
			basic_charge: 0
		}

		monthly_charge_list = []

		plans.map do |plan|
			# monthly_charge.append(plan["name"])

			if plan[:basic_charge][@ampere].present?
				monthly_charge_hash = [
					{
						name: plan[:plan],
						basic_charge: plan[:basic_charge][@ampere]
					}
				]
	
				monthly_charge = monthly_charge_hash.to_a
				monthly_charge_list.append(monthly_charge)
			end
			# binding.pry

			# monthly_charge_list.append(monthly_charge_hash)

		end

		puts monthly_charge_list
	end

	# private

end

user_amps = [10, 15, 20, 30, 40, 50, 60]
puts '契約しているアンペア数を入力してください'
amps = gets.to_i

puts "正しいアンペア数を入力してください" if !user_amps.include?(amps)

if user_amps.include?(amps)
	puts "1ヶ月あたりの使用量(kWh)を入力してください" if user_amps.include?(amps)

	used_energy_ammount = gets.to_i

	if used_energy_ammount >= 0
		simulator = Simulator.new(amps, used_energy_ammount)
	
		simulator.simulate
	else
		puts "正しい使用量を入力してください"		
	end

end

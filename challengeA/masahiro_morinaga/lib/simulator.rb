require "pry"
require 'active_model'
require 'yaml'

class Simulator
	include ActiveModel::Model

	def initialize(ampere, monthly_energy)
		@ampere = ampere
		@monthly_energy = monthly_energy
	end

	def simulate
		monthly_charge = {
			supplier: "",
			plan: "",
			price: 0,
		}
		puts calculate(monthly_charge)
		return calculate(monthly_charge)
	end

	def calculate(result)
		plans = YAML.load_file('../plan.yml')

		monthly_charge_list = []

		plans.map do |plan|
			@plan = plan
			if plan[:basic_charge][@ampere].present?
				if plan[:charge_per_use][:used_energy_classification].present?
					base_price = plan[:basic_charge][@ampere]
					low_price = 0
					first_price = 0
					second_price = 0
					third_price = 0
					fourth_price = 0

					first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first]) if @monthly_energy > plan[:charge_per_use][:used_energy_classification][:first]

					if plan[:charge_per_use][:used_energy_classification][:third].present?
						if @monthly_energy > plan[:charge_per_use][:used_energy_classification][:first] && @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:second]
							second_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						elsif @monthly_energy > plan[:charge_per_use][:used_energy_classification][:second] && @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:third]
							second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
							third_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
						elsif @monthly_energy > plan[:charge_per_use][:used_energy_classification][:third]
							second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
							third_price = ((plan[:charge_per_use][:used_energy_classification][:third] - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
							fourth_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:third]) * plan[:charge_per_use][:charge][:fourth])
						else
							low_price = (@monthly_energy * plan[:charge_per_use][:charge][:first]).floor
						end
					else
						if @monthly_energy > plan[:charge_per_use][:used_energy_classification][:first] &&  @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:second]
							second_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						elsif @monthly_energy > plan[:charge_per_use][:used_energy_classification][:second]
							second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
							third_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
						else
							low_price = (@monthly_energy * plan[:charge_per_use][:charge][:first]).floor
						end
					end
					price = (base_price + low_price + first_price + second_price + third_price + fourth_price).floor
				else
					price = (@monthly_energy * plan[:charge_per_use][:charge][:first]).floor
				end

				plan[:price] = price

				monthly_charge = {
					supplier: plan[:supplier],
					plan: plan[:plan],
					price: plan[:price]
				}

				monthly_charge_list.append(monthly_charge)
			end
		end
		return monthly_charge_list
	end
end

user_amps = [10, 15, 20, 30, 40, 50, 60]
puts '契約しているアンペア数を入力してください'
amps = gets.to_i

puts "正しいアンペア数を入力してください" if !user_amps.include?(amps)

if user_amps.include?(amps)
	puts "1ヶ月あたりの電気使用量(kWh)を入力してください" if user_amps.include?(amps)

	used_energy_ammount = gets.to_i

	if used_energy_ammount > 0
		simulator = Simulator.new(amps, used_energy_ammount)
	
		simulator.simulate
	else
		puts "正しい電気使用量を入力してください"		
	end
end

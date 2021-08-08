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
			if plan[:basic_charge][@ampere].present?
				case
				when plan[:name] == '東京電力', plan[:name] == '東京ガス' then
					if @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:first]
						plan[:price] = (plan[:basic_charge][@ampere] + @monthly_energy * plan[:charge_per_use][:charge][:first]).floor
					elsif @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:second]
						base_price = plan[:basic_charge][@ampere]
						first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first])
						second_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						plan[:price] = (base_price + first_price + second_price).floor
					else
						base_price = plan[:basic_charge][@ampere]
						first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first])
						second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						third_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
						plan[:price] = (base_price + first_price + second_price + third_price).floor
					end
				when plan[:name] == 'Looop' then
					plan[:price] = plan[:basic_charge][@ampere] + (@monthly_energy * plan[:charge_per_use][:charge][:first]).floor
				when plan[:name] == 'JXTG' then
					if @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:first]
						plan[:price] = plan[:basic_charge][@ampere] + (@monthly_energy * plan[:charge_per_use][:charge][:first]).floor
					elsif @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:second]
						base_price = plan[:basic_charge][@ampere]
						first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first])
						second_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						plan[:price] = (base_price + first_price + second_price).floor
					elsif @monthly_energy <= plan[:charge_per_use][:used_energy_classification][:third]
						base_price = plan[:basic_charge][@ampere]
						first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first])
						second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						third_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
						plan[:price] = (base_price + first_price + second_price + third_price).floor
					else
						base_price = plan[:basic_charge][@ampere]
						first_price = (plan[:charge_per_use][:used_energy_classification][:first] * plan[:charge_per_use][:charge][:first])
						second_price = ((plan[:charge_per_use][:used_energy_classification][:second] - plan[:charge_per_use][:used_energy_classification][:first]) * plan[:charge_per_use][:charge][:second])
						third_price = ((plan[:charge_per_use][:used_energy_classification][:third] - plan[:charge_per_use][:used_energy_classification][:second]) * plan[:charge_per_use][:charge][:third])
						fourth_price = ((@monthly_energy - plan[:charge_per_use][:used_energy_classification][:third]) * plan[:charge_per_use][:charge][:fourth])	
						plan[:price] = (base_price + first_price + second_price + third_price + fourth_price).floor
					end
				end

				monthly_charge = [
					{
						supplier: plan[:name],
						plan: plan[:plan],
						price: plan[:price]
					}
				]

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

	if used_energy_ammount >= 0
		simulator = Simulator.new(amps, used_energy_ammount)
	
		simulator.simulate
	else
		puts "正しい電気使用量を入力してください"		
	end
end

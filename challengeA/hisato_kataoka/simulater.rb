class Simulater
    
    # 契約アンペア数と消費電力量から対応するプランと電気料金を計算する。
    # input  amps:契約アンペア数    consumption:電気料金
    # return array_plan_info:プロバイダー、プラン名称、電気料金が格納されたハッシュを配列に格納したもの。
    def simulater(amps, consumption)

        checkamps(amps)

        array_plan_info = []

        array_plan_info.push({"provider" => "東京電力エナジーパートナー", "plan_name" => "従量電灯B", "price" => 0})
        array_plan_info.push({"provider" => "Loooop電気", "plan_name" => "おうちプラン", "price" => 0})
        array_plan_info.push({"provider" => "東京ガス株式会社", "plan_name" => "ずっとも電気１", "price" => 0})

        for plan_info in array_plan_info do
            provider = plan_info["provider"]
            plan_name = plan_info["plan_name"]
            plan_info["price"] = cal_base_price(provider,plan_name,amps) + cal_cosumption_price(provider,plan_name,consumption)
        end


        return array_plan_info
    end

    # 入力された契約アンペア数が適切かチェックし、適切でなければエラーを返す。
    # input  amps:契約アンペア数
    def checkamps(amps)
        targetamps = [10, 15, 20, 30, 40, 50, 60]
        if(!targetamps.include?(amps))
            raise "入力されている契約アンペアに対応するプランはありません"
        end
    end
            
    # 基本料金を計算する。
    # input  provider:プロバイダー名称    plan_name:プラン名称  amps:契約アンペア数
    # return 基本料金
    def cal_base_price(provider, plan_name, amps)
        if provider === "東京電力エナジーパートナー" && plan_name === "従量電灯B"
            case amps
            when 10 
                return 286
            when 15 
                return 429
            when 20
                return 572
            when 30
                return 858
            when 40
                return 1144
            when 50
                return 1410
            when 60
                return 1716
            end
        elsif provider === "Loooop電気" && plan_name === "おうちプラン"
            return 0
        elsif provider === "東京ガス株式会社" && plan_name === "ずっとも電気１"
            if amps <= 30
                return 858
            elsif amps === 40
                return 1144
            elsif amps === 50
                return 1410
            elsif amps === 60
                return 1716
            end
        end
    end

    # 従量料金を計算する。
    # input  provider:プロバイダー名称    plan_name:プラン名称  consumption:電気使用量
    # return price:従量料金
    def cal_cosumption_price(provider, plan_name, consumption)
        price = 0

        if provider === "東京電力エナジーパートナー" && plan_name === "従量電灯B"
            ryokin_kbn1 = 19.88
            ryokin_kbn2 = 26.48
            ryokin_kbn3 = 30.57
            consumption_border_line1 = 120 #使用量境界１
            consumption_border_line2 = 300 #使用量境界２
            # 使用量が使用量境界１までの分
            if consumption <= consumption_border_line1
                price = consumption * ryokin_kbn1
            # 使用量が使用量境界１から使用量境界２までの分
            elsif consumption > consumption_border_line1 && consumption <= consumption_border_line2
                price = consumption_border_line1 * ryokin_kbn1 + (consumption-consumption_border_line1) * ryokin_kbn2
            # 使用量が使用量境界２を超える分
            elsif consumption > consumption_border_line2
                price = consumption_border_line1 * ryokin_kbn1 + (consumption_border_line2 - consumption_border_line1) * ryokin_kbn2 \
                         + (consumption - consumption_border_line2) * ryokin_kbn3
            end

            return price

        elsif provider === "Loooop電気" && plan_name === "おうちプラン"
            ryokin_kbn1 = 26.4
            price = consumption * ryokin_kbn1

            return price

        elsif provider === "東京ガス株式会社"  && plan_name === "ずっとも電気１"
            ryokin_kbn1 = 23.67
            ryokin_kbn2 = 23.88
            ryokin_kbn3 = 26.41
            consumption_border_line1 = 140 #使用量境界１
            consumption_border_line2 = 350 #使用量境界２
            # 使用量が使用量境界１までの分
            if consumption <= consumption_border_line1
                price = consumption * ryokin_kbn1
            # 使用量が使用量境界１から使用量境界２までの分
            elsif consumption > consumption_border_line1 && consumption <= consumption_border_line2
                price = consumption_border_line1 * ryokin_kbn1 + (consumption-consumption_border_line1) * ryokin_kbn2
            # 使用量が使用量境界２を超える分
            elsif consumption > consumption_border_line2
                price = consumption_border_line1 * ryokin_kbn1 + (consumption_border_line2 - consumption_border_line1) * ryokin_kbn2 \
                         + (consumption - consumption_border_line2) * ryokin_kbn3
            end

            return price
        end
    end
end

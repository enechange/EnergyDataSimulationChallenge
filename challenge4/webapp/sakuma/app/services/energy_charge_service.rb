class EnergyChargeService

  def initialize(request)
    @request = request
    @charge_response = OpenStruct.new
  end

  def serve!
    @charge_response.status = 200
    @charge_response.message = 'Successful HTTP requests.'
    @charge_response.request_id = @request.uuid
    @charge_response.energy_charges = []

    RatePlan.each do |plan|
      calculator = EnergyCharge::Calculator.new(plan: plan, consumptions: request_json)
      charge = OpenStruct.new(plan_name: plan.name, price: calculator.calc)
      @charge_response.energy_charges << charge
    end

    @charge_response
  end

  private

  def request_json
    @json ||= JSON.parse(@request.body.read)
  end
end

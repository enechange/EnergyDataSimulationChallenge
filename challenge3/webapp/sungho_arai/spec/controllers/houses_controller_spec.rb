require 'spec_helper'

describe HousesController do
  fixtures :houses
  describe "GET /houses/:id" do

    describe :routes do
      subject { {:get => "/houses/1"} }
      it { should route_to(controller: "houses", action: "show", id: "1") }
    end

    before { get :show, :id => "1" }
    describe :response do
      subject { response }
      it { should be_success }
    end

  end
end

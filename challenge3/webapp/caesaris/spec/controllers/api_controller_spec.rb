require "rails_helper"

RSpec.describe ApiController, type: :controller do
  it "Create dummy users" do
    email = "admin-user@example.org"
    pass = "12345678"
    @admin_user = User.create!({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ["admin"]
    })
    email = "nomal-user@example.org"
    @normal_user = User.create!({
      email: email, password: pass,
      password_confirmation: pass
    })
    expect(@admin_user).to be_truthy
    expect(@normal_user).to be_truthy
  end

  describe "Normal API" do
    it "Should get default_user" do
      get :default_user
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(res["email"]).to eq EasySettings.default_user.email
    end

    it "Should get demo_user" do
      # Stub for EasySettings.default_user.show
      allow(EasySettings.default_user).to receive(:show).and_return(false)
      AppConfig.general[:show_demo_user] = true

      get :default_user
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(res["email"]).to eq EasySettings.demo_user.email
    end

    it "Should not get any user" do
      allow(EasySettings.default_user).to receive(:show).and_return(false)
      AppConfig.general[:show_demo_user] = false

      get :default_user
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(res["email"]).to be_falsey
    end
  end

  describe "Secured API" do
    before do
      @user = User.admin.first
      sign_in @user
    end

    context "api#user_info" do
      it "Should return current_user" do
        get :user_info
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(res["roles"]).to eq ["admin"]
      end
    end

    context "api#load_csv" do
      it "Should raise error if no url" do
        post :load_csv
        res = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(res["error"]).to be_truthy
      end

      it "Should raise error if no key" do
        post :load_csv, params: {
          house_data_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv",
          dataset_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv",
        }
        res = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(res["error"]).to be_truthy
      end

      it "Should load challenge-3 data csv from URL" do
        post :load_csv, params: {
          key: "challenge-3",
          house_data_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv",
          dataset_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv",
        }
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(res["result"]).to eq "ok"
      end
    end

    context "api#create_user" do
      it "Should raise error if not admin" do
        @normal_user = User.where(email: "nomal-user@example.org").first
        sign_in @normal_user
        post :create_user
        res = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(res["error"]).to be_truthy
      end

      it "Should create a user" do
        expect {
          post :create_user, params: {
            email: "test-3@example.com",
            password: "12345678",
            roles: ["observer"],
          }
        }.to change(User, :count).by(1)
        expect(User.find_by(email: "test-3@example.com")).to be_truthy
      end
    end
  end
end

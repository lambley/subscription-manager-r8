require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let!(:subscription) { create(:subscription, user: user) }

    before do
      log_in(user)
      allow(Current).to receive(:user).and_return(user)
    end

    after do
      log_out
    end

    it "returns http success" do
      get subscriptions_path
      expect(response).to have_http_status(:success)
    end

    it "should have the correct url" do
      get subscriptions_path
      expect(request.original_fullpath).to eq(subscriptions_path)
    end

    it "should have the correct instance variable" do
      get subscriptions_path
      expect(assigns(:subscriptions)).to eq([ subscription ])
    end
  end
end

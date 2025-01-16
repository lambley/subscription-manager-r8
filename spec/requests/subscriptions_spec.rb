require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  let(:user) { create(:user) }
  let!(:subscription) { create(:subscription, user: user) }

  before do
    log_in(user)
    allow(Current).to receive(:user).and_return(user)
  end

  after do
    log_out
  end

  describe "GET /index" do
    it_behaves_like 'GET request examples', :get
  end

  describe "GET /show" do
    it_behaves_like 'GET request examples', :get
  end

  describe "GET /edit" do
    it_behaves_like 'GET request examples', :get
  end

  describe "PATCH /update" do
    context "with valid params" do
      let (:updated_params) { { name: "Updated Name" } }

      before do
        patch subscription_path(subscription), params: { subscription: updated_params }
        subscription.reload
      end

      it_behaves_like 'PATCH request examples', "Subscription was successfully updated."
    end

    context "with invalid params" do
      let (:updated_params) { { name: "" } }

      before do
        patch subscription_path(subscription), params: { subscription: updated_params }
        subscription.reload
      end

      it_behaves_like 'PATCH invalid request examples'
    end
  end

  describe "DELETE /destroy" do
    it_behaves_like 'DELETE request examples', "Subscription was successfully destroyed."
  end
end

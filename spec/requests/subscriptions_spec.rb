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

    context 'with search param' do
      let!(:subscription2) { create(:subscription, user: user, name: "amazon_prime_video") }

      before do
        get subscriptions_path, params: { search: "amazon" }
      end

      it 'returns only the subscription with the searched name' do
        expect(response.body).to include(subscription2.name.titleize)
        expect(response.body).not_to include(subscription.name.titleize)
      end

      it 'returns all subscriptions when search param is empty' do
        get subscriptions_path, params: { search: "" }
        expect(response.body).to include(subscription.name.titleize)
        expect(response.body).to include(subscription2.name.titleize)
      end
    end
  end

  describe "GET /show" do
    it_behaves_like 'GET request examples', :get
  end

  describe "GET /new" do
    it_behaves_like 'GET request examples', :get

    it 'returns a new subscription object' do
      get new_subscription_path
      expect(assigns(:subscription)).to be_a_new(Subscription)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let (:valid_params) { attributes_for(:subscription) }

      it_behaves_like 'POST request examples', "Subscription was successfully created."
    end

    context "with invalid params" do
      let (:invalid_params) { { name: "" } }

      it_behaves_like 'POST invalid request examples'
    end
  end

  describe "GET /edit" do
    it_behaves_like 'GET request examples', :get

    it 'returns the correct subscription object' do
      get edit_subscription_path(subscription)
      expect(assigns(:subscription)).to eq(subscription)
    end
  end

  describe "PATCH /update" do
    context "with valid params" do
      let (:updated_params) { { name: "amazon_prime_video" } }

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

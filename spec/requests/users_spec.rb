require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:subscription) { create(:subscription, user: user) }

  before do
    log_in(user)
  end

  describe "edit_budget" do
    it "finds the current user" do
      get edit_budget_path
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "update_budget" do
    it "finds the current user" do
      patch update_budget_path(user), params: { user: { budget: 1000 } }
      expect(assigns(:user)).to eq(user)
    end

    context "with valid params" do
      it "updates the user's budget" do
        patch update_budget_path(user), params: { user: { budget: 1000 } }
        expect { user.reload }.to change(user, :budget).to(1000)
      end
    end

    context "with invalid params" do
      it "does not update the user's budget" do
        patch update_budget_path(user), params: { user: { budget: -1 } }
        expect { user.reload }.not_to change(user, :budget)
      end
    end
  end
end

RSpec.shared_examples 'total cost examples' do | billing_frequency |
  let(:user) { create(:user) }
  let(:subscription_1) { create(:subscription, user: user, price: 10, billing_frequency: "monthly") }
  let(:subscription_2) { create(:subscription, user: user, price: 120, billing_frequency: "annual") }
  let(:subscription_3) { create(:subscription, user: user, price: 0, billing_frequency: "monthly") }

  context "#{billing_frequency} billing frequency" do
    it "returns the total cost of all subscriptions" do
      monthly_expected = "20.00"
      annual_expected = "240.00"

      expected = billing_frequency == "monthly" ? monthly_expected : annual_expected

      expect(helper.total_cost([ subscription_1, subscription_2 ], billing_frequency)).to eq(expected)
    end

    it "returns 0 for an empty subscription list" do
      expect(helper.total_cost([], billing_frequency)).to eq("0.00")
    end

    it "handles subscriptions with a price of zero" do
      monthly_expected = "10.00"
      annual_expected = "120.00"

      expected = billing_frequency == "monthly" ? monthly_expected : annual_expected

      expect(helper.total_cost([ subscription_1, subscription_3 ], billing_frequency)).to eq(expected)
    end
  end

  context "invalid billing frequency" do
    it "returns 0 for an invalid billing frequency" do
      expect(helper.total_cost([ subscription_1, subscription_2 ], "invalid")).to eq("0.00")
    end
  end
end

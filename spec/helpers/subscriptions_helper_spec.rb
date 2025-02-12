require 'rails_helper'

RSpec.describe SubscriptionsHelper, type: :helper do
  let (:user) { create(:user) }
  let (:subscription) { create(:subscription, user: user) }

  describe '#currency_symbol' do
    it 'returns the correct currency symbol for the locale' do
      expect(helper.currency_symbol('gb')).to eq('£')
      expect(helper.currency_symbol('us')).to eq('$')
    end

    it 'returns the default currency symbol for an invalid locale' do
      expect(helper.currency_symbol('invalid')).to eq('£')
    end
  end

  describe '#total_cost' do
    it_behaves_like 'total cost examples', 'monthly'
    it_behaves_like 'total cost examples', 'annual'
  end

  describe '#render_subscription_summary_table' do
    it 'renders the subscription summary table partial with the correct locals' do
      budget = 120
      locale = 'gb'
      subscriptions = [ subscription ]
      allow(helper).to receive(:total_cost).with(subscriptions, 'monthly').and_return('9.99')
      allow(helper).to receive(:total_cost).with(subscriptions, 'annual').and_return('99.99')

      expect(helper).to receive(:render).with(partial: 'subscriptions/summary/table', locals: {
        subscriptions: subscriptions,
        budget_set: true,
        monthly_actual: '9.99',
        annual_actual: '99.99',
        monthly_budget: '10.00',
        annual_budget: '120.00',
        currency_symbol: '£'
      })

      helper.render_subscription_summary_table(subscriptions: subscriptions, budget: budget, locale: locale)
    end
  end

  describe '#formatted_subscription_name' do
    it 'returns the subscription name in the correct format' do
      [ 'netflix', 'amazon_prime_video' ].each do |name|
        expect(helper.formatted_subscription_name(name)).to eq(name.titleize)
      end
    end
  end

  describe '#formatted_subscription_names' do
    it 'returns the subscription names in the correct format' do
      expected_result =
        Subscription.subscription_names.map { |name| [ name.titleize, name ] }

      expect(helper.formatted_subscription_names).to eq(expected_result)
    end
  end
end

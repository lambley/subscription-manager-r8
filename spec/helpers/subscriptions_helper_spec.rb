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
end

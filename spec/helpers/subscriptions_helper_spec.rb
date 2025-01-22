require 'rails_helper'

RSpec.describe SubscriptionsHelper, type: :helper do
  let (:user) { create(:user) }
  let (:subscription) { create(:subscription, user: user) }

  describe '#subscription_status' do
    it 'returns status' do
      # default factory creates an active subscription with dynamic date ranges +- 1 month
      expect(helper.subscription_status(subscription)).to include('Active')
    end

    context 'active' do
      let (:subscription) { create(:subscription, user: user, expires_at: 1.month.from_now) }

      it 'returns a content_tag with "Active" text' do
        expect(helper.subscription_status(subscription)).to include('Active')
      end

      it 'returns a content_tag with the correct tailwind classes' do
        expect(helper.subscription_status(subscription)).to include('bg-green-500 text-white px-4 py-1 rounded-full')
      end
    end

    context 'inactive' do
      let (:subscription) { create(:subscription, user: user, started_at: 2.month.ago, expires_at: 1.month.ago) }

      it 'returns a content_tag with "Active" text' do
        expect(helper.subscription_status(subscription)).to include('Inactive')
      end

      it 'returns a content_tag with the correct tailwind classes' do
        expect(helper.subscription_status(subscription)).to include('bg-red-500 text-white px-4 py-1 rounded-full')
      end
    end
  end

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

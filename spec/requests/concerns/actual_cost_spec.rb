require 'rails_helper'

RSpec.describe ActualCost, type: :concern do
  class DummyClass
    include ActualCost
  end

  subject { DummyClass.new }

  describe '#calculate_actual_cost' do
    # collection of subscriptions:
    # 1 - active 2 months ago - expired last month
    # 2 - active last month - expires next month
    # 3 - inactive this month - starts in 3 months

    let (:subscriptions) { [ subscription1, subscription2, subscription3 ] }
    let (:subscription1) { Subscription.new(name: 'Netflix', price: 10, billing_frequency: 'monthly', started_at: Date.today - 2.month, expires_at: Date.today - 1.month) }
    let (:subscription2) { Subscription.new(name: 'Hulu', price: 5, billing_frequency: 'monthly', started_at: Date.today - 1.month, expires_at: Date.today + 1.month) }
    let (:subscription3) { Subscription.new(name: 'Disney+', price: 7, billing_frequency: 'monthly', started_at: Date.today + 3.month, expires_at: Date.today + 11.month) }

    context 'when the billing frequency is monthly' do
      it 'returns the total cost of active subscriptions for the current month' do
        # testing the current month - only subscription2 is active
        expect(subject.total_cost(subscriptions, 'monthly', Date.today)).to eq('5.00')
      end

      it 'returns the total cost of active subscriptions for a specific month' do
        # testing 2 months from now - no subscriptions are active
        expect(subject.total_cost(subscriptions, 'monthly', Date.today + 2.month)).to eq('0.00')
      end
    end

    context 'when the billing frequency is annual' do
      it 'returns the sum of monthly costs for active subscriptions over the next 12 months' do
        # expected: subscription2 is active this month and next month
        # expected: subscription3 is active 3 months from now to 11 months from now
        # expected sum: (subscription2.price * 2) + (subscription3.price * 9) = (5 * 2) + (7 * 9) = 10 + 63 = 73
        expect(subject.total_cost(subscriptions, 'annual', Date.today)).to eq('73.00')
      end
    end
  end
end

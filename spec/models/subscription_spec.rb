require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'associations' do
    it 'belongs to a user' do
      expect(Subscription.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'returns the expected user' do
      user = create(:user)
      subscription = create(:subscription, user: user)
      expect(subscription.user).to eq(user)
    end
  end

  context 'validations' do
    let (:user) { create(:user) }
    let (:subscription) { create(:subscription, user: user) }

    it 'is valid with valid attributes' do
      expect(subscription).to be_valid
    end

    it 'is not valid without a user' do
      subscription.user = nil
      expect(subscription).to_not be_valid
    end

    it 'is not valid without a name' do
      subscription.name = nil
      expect(subscription).to_not be_valid
    end

    it 'is not valid without a price' do
      subscription.price = nil
      expect(subscription).to_not be_valid
    end

    it 'is not valid with a negative price' do
      subscription.price = -1
      expect(subscription).to_not be_valid
    end

    context 'billing frequency' do
      it 'is not valid without a billing frequency' do
        subscription.billing_frequency = nil
        expect(subscription).to_not be_valid
      end

      it 'is not valid with an invalid billing frequency' do
        subscription.billing_frequency = 'invalid'
        expect(subscription).to_not be_valid
      end

      it 'is case insensitive' do
        subscription.billing_frequency = 'MONTHLY'
        expect(subscription).to be_valid
      end
    end

    it 'is valid with a valid started at date' do
      subscription.started_at = 1.day.ago
      expect(subscription).to be_valid
    end

    it 'is not valid with an invalid started at date' do
      subscription.started_at = 'invalid'
      # the above is not a DateTime and is cast to nil. The model will add an ActiveRecord error if the attribute is nil.
      expect(subscription).to_not be_valid
    end

    it 'is valid with a valid expires at date' do
      subscription.expires_at = 1.day.from_now
      expect(subscription).to be_valid
    end

    it 'is not valid with an invalid expires at date' do
      subscription.expires_at = 'invalid'
      # the above is not a DateTime and is cast to nil. The model will add an ActiveRecord error if the attribute is nil.
      expect(subscription).to_not be_valid
    end

    it 'is not valid with a started at date after the expires at date' do
      subscription.started_at = 1.days.ago
      subscription.expires_at = 2.day.ago
      expect(subscription).to_not be_valid
    end
  end

  context 'methods' do
    let (:user) { create(:user) }
    let (:subscription) { create(:subscription, user: user) }

    it 'returns true if the subscription is active' do
      subscription.started_at = 1.day.ago
      subscription.expires_at = 1.day.from_now
      expect(subscription.active?).to be_truthy
    end

    it 'returns false if the subscription is not active' do
      subscription.started_at = 2.days.ago
      subscription.expires_at = 1.day.ago
      expect(subscription.active?).to be_falsey
    end
  end
end

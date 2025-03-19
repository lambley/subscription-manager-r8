module ActualCost
  extend ActiveSupport::Concern

  def total_cost(subscriptions, billing_frequency, month = Date.today)
    total = 0

    case billing_frequency
    when "monthly"
      total = calculate_montly_cost(subscriptions, month)
    when "annual"
      (0..11).each do |i|
        total += calculate_montly_cost(subscriptions, month + i.months)
      end
    end

    sprintf("%.2f", total)
  end

  private

  def calculate_montly_cost(subscriptions, month)
    total = 0

    subscriptions.each do |subscription|
      total += subscription.price if subscription.active_for_month?(month)
    end

    total
  end
end

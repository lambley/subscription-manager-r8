module ActualCost
  extend ActiveSupport::Concern

  # contains class methods for calculating monthly and annual actual costs
  def total_cost(subscriptions, billing_frequency)
    total = 0

    case billing_frequency
    when "monthly"
      total += subscriptions.select { |s| s.billing_frequency == "monthly" }.sum(&:price)
      total += subscriptions.select { |s| s.billing_frequency == "annual" }.sum(&:price) / 12.0
    when "annual"
      total += subscriptions.select { |s| s.billing_frequency == "annual" }.sum(&:price)
      total += subscriptions.select { |s| s.billing_frequency == "monthly" }.sum(&:price) * 12.0
    end
    sprintf("%.2f", total)
  end
end

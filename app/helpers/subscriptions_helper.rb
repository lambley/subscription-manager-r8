module SubscriptionsHelper
  def currency_symbol(locale)
    I18n.t("number.currency.#{locale}.symbol", default: I18n.t("number.currency.default.symbol"))
  end

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
    total
  end
end

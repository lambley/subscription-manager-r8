module SubscriptionsHelper
  def subscription_status(subscription)
    if subscription.active?
      content_tag(:span, "Active", class: "bg-green-500 text-white px-4 py-1 rounded-full")
    else
      content_tag(:span, "Inactive", class: "bg-red-500 text-white px-4 py-1 rounded-full")
    end
  end

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

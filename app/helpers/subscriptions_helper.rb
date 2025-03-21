module SubscriptionsHelper
  include ActualCost

  def currency_symbol(locale)
    I18n.t("number.currency.#{locale}.symbol", default: I18n.t("number.currency.default.symbol"))
  end

  def render_subscription_summary_table(subscriptions:, budget:, locale:)
    budget_set = budget.present?
    monthly_actual = total_cost(subscriptions, "monthly")
    annual_actual = total_cost(subscriptions, "annual")
    monthly_budget = budget_set ? sprintf("%.2f", (budget / 12).round(2)) : "Budget not set"
    annual_budget = budget_set ? sprintf("%.2f", budget.round(2)) : "Budget not set"
    currency_symbol = currency_symbol(locale)

    render partial: "subscriptions/summary/table", locals: {
      subscriptions: subscriptions,
      budget_set: budget_set,
      monthly_actual: monthly_actual,
      annual_actual: annual_actual,
      monthly_budget: monthly_budget,
      annual_budget: annual_budget,
      currency_symbol: currency_symbol
    }
  end

  def formatted_subscription_name(name)
    name.titleize
  end

  def formatted_subscription_names
    Subscription.subscription_names.map { |name| [ formatted_subscription_name(name), name ] }
  end
end

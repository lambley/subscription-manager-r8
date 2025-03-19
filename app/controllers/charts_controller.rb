class ChartsController < ApplicationController
  include ActualCost

  def budget_v_actual
    # params will pass frequency (monthly or annual) and budget
    @frequency = params[:frequency] || "monthly"
    @annual_budget = params[:annual_budget].to_f || 0
    # subscriptions will be fetched from the current user
    @subscriptions = Current.user.subscriptions
    # render the chart as json
    data = budget_v_actual_data(@subscriptions, @annual_budget, @frequency)

    p data

    render json: data
  end

  private

  def budget_v_actual_data(subscriptions, budget, frequency)
    current_month = Date.today.beginning_of_month
    data = [
      { name: "Budgeted", data: {} },
      { name: "Actual", data: {} }
    ]

    12.times do |i|
      month = current_month + i.months
      month_name = month.strftime("%b '%y")
      data[0][:data][month_name] = (budget / 12).round(2)
      data[1][:data][month_name] = total_cost(subscriptions, frequency, month)
    end

    data
  end
end

class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Current.user.subscriptions
  end

  def show
    @subscription = Current.user.subscriptions.find(params[:id])
  end
end

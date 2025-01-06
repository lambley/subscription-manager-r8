class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Current.user.subscriptions
  end
end

class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Current.user.subscriptions
  end

  def show
    @subscription = Current.user.subscriptions.find(params[:id])
  end

  def edit
    @subscription = Current.user.subscriptions.find(params[:id])
  end

  def update
    @subscription = Current.user.subscriptions.find(params[:id])
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: "Subscription was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @subscription = Current.user.subscriptions.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path, notice: "Subscription was successfully destroyed."
  end

  private

  def subscription_params
    params.require(:subscription).permit(:name, :price, :billing_frequency, :started_at, :expires_at)
  end
end

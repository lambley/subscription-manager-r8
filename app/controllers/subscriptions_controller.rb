class SubscriptionsController < ApplicationController
  def index
    if params[:search].present?
      @subscriptions = Current.user.subscriptions.where('name ILIKE ?', "%#{params[:search]}%")
    elsif params[:clear].present?
      @subscriptions = Current.user.subscriptions
    else
      @subscriptions = Current.user.subscriptions
    end

    respond_to do |format|
      format.html
      format.js { render partial: 'subscriptions_list', locals: { subscriptions: @subscriptions } }
    end
  end

  def show
    @subscription = Current.user.subscriptions.find(params[:id])
  end

  def new
    @subscription = Current.user.subscriptions.new
  end

  def create
    @subscription = Current.user.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to @subscription, notice: "Subscription was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
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

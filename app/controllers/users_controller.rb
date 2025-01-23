class UsersController < ApplicationController
  def edit_budget
    @user = Current.user
  end

  def update_budget
    @user = Current.user

    if @user.update(budget_params)
      redirect_to subscriptions_path, status: :ok, notice: "Budget was successfully updated"
    else
      redirect_to subscriptions_path, status: :unprocessable_entity, alert: "Budget could not be updated"
    end
  end

  private

  def budget_params
    params.require(:user).permit(:budget)
  end
end

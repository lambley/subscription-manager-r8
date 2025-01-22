class UsersController < ApplicationController
  def edit_budget
    @user = Current.user
  end

  def update_budget
    @user = Current.user

    if @user.update(budget_params)
      render json: { budget: @user.budget }, status: :ok
      flash[:notice] = "Budget updated successfully"
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      flash[:alert] = "Budget could not be updated"
    end
  end

  private

  def budget_params
    params.require(:user).permit(:budget)
  end
end

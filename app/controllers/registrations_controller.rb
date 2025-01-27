class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: 'Successfully signed up!'
    else
      render :new, status: :unprocessable_entity, alert: 'Unable to sign up.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :locale,:email_address, :password, :password_confirmation)
  end
end

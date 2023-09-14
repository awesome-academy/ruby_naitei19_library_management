class AccountActivationsController < ApplicationController
  before_action :find_user, only: %i(edit update)

  def edit
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "account_activated"
      redirect_to user
    else
      invalid_activation_method
    end
  end

  def update; end

  private

  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  # fix rubocop too high
  def invalid_activation_method
    flash[:danger] = t "invalid_activation"
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  before_action :find_user, only: :create
  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      reset_session
      log_in @user
      if @user.admin?
        redirect_to admin_root_path
      else
        redirect_to user
      end
    else
      # Create an error message.
      flash.now[:danger] = t("invalid_mess")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def find_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return unless @user.nil?

    flash[:danger] = t("session_danger")
    redirect_to action: :new, status: :unprocessable_entity
  end
end

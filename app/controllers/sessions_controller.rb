class SessionsController < ApplicationController
  before_action :find_user, only: :create
  def new; end

  def create
    if @user&.authenticate(params.dig(:session, :password))
      handle_successful_login @user
    else
      handle_failed_login
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

  def handle_successful_login user
    if user.activated
      reset_session
      log_in user
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_url
        flash[:success] = t("login_successfull", name: user.name)
      end
    else
      flash[:warning] = t "account_not_activated"
      redirect_to root_url
    end
  end

  # Fix rubocop too high
  def handle_failed_login
    # Create an error message.
    flash.now[:danger] = t("invalid_mess")
    render :new, status: :unprocessable_entity
  end
end

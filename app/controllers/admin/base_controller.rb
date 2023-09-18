class Admin::BaseController < ApplicationController
  layout "layouts/application_admin"
  before_action :check_admin_role

  private

  def check_admin_role
    return if current_user&.admin?

    flash[:alert] = t("not_admin")
    redirect_to root_path
  end
end

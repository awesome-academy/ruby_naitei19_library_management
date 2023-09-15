class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: :active

  def index
    name = params[:user_search] || ""
    @users = User.filtered_by_name(name)
                 .paginate(page: params[:page],
                           per_page: Settings.per_page)
  end

  def active
    if @user && !@user.activated
      @user.activate
      flash[:success] = t "account_activated"
    else
      @user.inactivate
      flash[:success] = t "account_inactivated"
    end
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("admin.user.not_found")
    redirect_to admin_users_path
  end
end

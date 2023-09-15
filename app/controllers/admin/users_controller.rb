class Admin::UsersController < Admin::BaseController
  before_action :find_user, except: %i(index)

  def index
    name = params[:user_search] || ""
    @users = User.filtered_by_name(name)
                 .paginate(page: params[:page],
                           per_page: Settings.per_page)
  end

  def active; end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("admin.user.not_found")
    redirect_to admin_users_path
  end
end

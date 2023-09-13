class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, except: %i(index new create)
  def index
    @categories = Category.filtered_by_name(params[:category_search]).paginate(
      page: params[:page],
      per_page: Settings.per_page
    )
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("admin.category.create_success")
      redirect_to admin_categories_path
    else
      flash[:warning] = t("admin.category.create_fail")
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @category = Category.new
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = t("admin.category.update_success")
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
      flash[:warning] = t("admin.category.update_fail")
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t("admin.category.destroy_success")
    else
      flash[:warning] = t("admin.category.destroy_fail")
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t("admin.category.not_found")
    redirect_to admin_categories_path
  end
end

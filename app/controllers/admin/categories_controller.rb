class Admin::CategoriesController < Admin::BaseController
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

  def edit; end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end
end

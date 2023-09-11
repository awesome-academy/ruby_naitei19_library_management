class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.filtered_by_name(params[:category_search]).paginate(
      page: params[:page],
      per_page: Settings.per_page
    )
  end

  def new; end

  def edit; end

  def destroy; end
end

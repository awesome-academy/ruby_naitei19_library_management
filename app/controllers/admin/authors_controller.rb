class Admin::AuthorsController < Admin::BaseController
  before_action :find_author, except: %i(index new create)
  def index
    @search = Author.ransack(params[:q])
    @authors = @search.result(distinct: true).paginate(page: params[:page],
                                                       per_page:
                                                       Settings.per_page)
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = t("admin.author.create_success")
      redirect_to admin_author_path(@author)
    else
      flash[:warning] = t("admin.author.create_fail")
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @author = Author.new
  end

  def edit; end

  def show; end

  def update
    if @author.update(author_params)
      flash[:success] = t("admin.author.update_success")
      redirect_to admin_author_path(@author)
    else
      render :edit, status: :unprocessable_entity
      flash[:warning] = t("admin.author.update_fail")
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t("admin.author.destroy_success")
    else
      flash[:warning] = t("admin.author.destroy_fail")
    end
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :country, :date_of_birth, :avatar)
  end

  def find_author
    @author = Author.find_by id: params[:id]
    return if @author

    flash[:danger] = t("admin.author.not_found")
    redirect_to admin_authors_path
  end
end

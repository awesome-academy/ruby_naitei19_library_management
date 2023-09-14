class Admin::PublishersController < Admin::BaseController
  before_action :find_publisher, except: %i(index new create)
  def index
    name = params[:publisher_search] || ""
    @publishers = Publisher.filtered_by_name(name).paginate(page: params[:page],
                                                            per_page:
                                                            Settings.per_page)
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      flash[:success] = t("admin.publisher.create_success")
      redirect_to admin_publishers_path
    else
      flash[:warning] = t("admin.publisher.create_fail")
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @publisher = Publisher.new
  end

  def edit; end

  def show; end

  def update
    if @publisher.update(publisher_params)
      flash[:success] = t("admin.publisher.update_success")
      redirect_to admin_publisher_path(@publisher)
    else
      render :edit, status: :unprocessable_entity
      flash[:warning] = t("admin.publisher.update_fail")
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t("admin.publisher.destroy_success")
    else
      flash[:warning] = t("admin.publisher.destroy_fail")
    end
    redirect_to admin_publishers_path
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :email, :address)
  end

  def find_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher

    flash[:danger] = t("admin.publisher.not_found")
    redirect_to admin_publishers_path
  end
end

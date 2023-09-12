class Admin::PublishersController < Admin::BaseController
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

  def destroy; end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :email, :address)
  end
end

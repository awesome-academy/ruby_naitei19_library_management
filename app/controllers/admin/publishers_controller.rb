class Admin::PublishersController < Admin::BaseController
  def index
    name = params[:publisher_search] || ""
    @publishers = Publisher.filtered_by_name(name).paginate(page: params[:page],
                                                            per_page:
                                                            Settings.per_page)
  end

  def new; end

  def edit; end

  def destroy; end
end

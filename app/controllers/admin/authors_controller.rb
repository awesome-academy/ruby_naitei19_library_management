class Admin::AuthorsController < Admin::BaseController
  def index
    name = params[:author_search] || ""
    @authors = Author.filtered_by_name(name).paginate(page: params[:page],
                                                      per_page:
                                                      Settings.authors.per_page)
  end

  def new; end

  def edit; end

  def destroy; end
end

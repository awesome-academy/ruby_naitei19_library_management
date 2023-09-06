class AuthorsController < ApplicationController
  before_action :find_author, only: %i(show)

  def index
    @authors = Author.paginate(page: params[:page],
                               per_page: Settings.authors.per_page)
  end

  def show; end

  private

  def find_author
    @author = Author.find_by(id: params[:id])
    return if @author.present?

    redirect_to(authors_path, status: :see_other,
                flash: {danger: t("authors.show.author_not_found")})
  end
end

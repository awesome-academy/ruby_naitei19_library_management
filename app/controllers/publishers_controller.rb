class PublishersController < ApplicationController
  before_action :find_publisher, only: :show
  def index
    @publishers = Publisher.search_all(params[:search] || "")
                           .distinct
                           .paginate(page: params[:page],
                                     per_page: Settings.page.limit_items)
  end

  def show; end
  private

  def find_publisher
    @publisher = Publisher.find_by(id: params[:id])
    return if @publisher.present?

    redirect_to(publishers_path, status: :see_other,
                flash: {danger: t("publishers.show.publisher_not_found")})
  end
end

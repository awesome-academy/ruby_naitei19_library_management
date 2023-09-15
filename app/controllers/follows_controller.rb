class FollowsController < ApplicationController
  before_action :logged_in_user
  before_action :find_followable_by_url
  def create
    @followed = current_user.follows.new followable: @followable
    flash[:danger] = t("follow_fail") unless @followed.save
    redirect_to @followable
  end

  def destroy
    current_user.follows.destroy(current_user.follows
              .find_by(followable: @followable))
    redirect_to @followable
  end

  private

  def find_followable_by_url
    if request.original_url.include?("publisher")
      @followable = Publisher.find_by id: params[:publisher_id]
    elsif request.original_url.include?("authors")
      @followable = Author.find_by id: params[:author_id]
    else
      flash[:danger] = t("wrong")
    end
  end
end

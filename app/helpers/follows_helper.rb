module FollowsHelper
  def find_followed_by_url
    if request.original_url.include?("publishers")
      @followed = Publisher.find_by id: params[:id]
    elsif request.original_url.include?("authors")
      @followed = Author.find_by id: params[:id]
    else
      flash[:danger] = t("wrong")
    end
  end

  def followed
    find_followed_by_url
    current_user.follows.find_by followable: @followed
  end

  def followed?
    find_followed_by_url
    current_user.follows.exists?(followable: @followed)
  end
end

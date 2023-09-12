class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book
  before_action :load_review
  def new
    @review = current_user.reviews.new
  end

  def create
    @review = @book.reviews.new review_params
    @review.user_id = current_user.id

    if @review.save
      update_average_rating
      flash[:success] = t("review.add_success")

    else
      flash[:danger] = t("review.add_fail")

    end
    redirect_to book_path(@book)
  end

  def edit; end

  def update
    if @review.update(review_params)
      update_average_rating
      flash[:success] = t("review.update_success")
    else
      flash.now[:danger] = t("review.update_fail")
    end
    redirect_to book_path(@book)
  end

  def destroy
    if @review.destroy
      update_average_rating
      flash[:success] = t("review.delete_success")
    else
      flash[:danger] = t("review.delete_fail")
    end
    redirect_to book_path(@book)
  end

  private
  def review_params
    params.require(:review).permit :comment, :rating
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
  end

  def load_review
    @review = current_user.reviews.find_by book_id: @book.id
  end

  def update_average_rating
    @book.reload
    reviews = @book.reviews
    total_rating = reviews.sum(:rating)

    Book.transaction do
      @book.update!(average_rating: total_rating.to_f / reviews.count)
    rescue StandardError => e
      flash[:danger] = e
      raise ActiveRecord::Rollback
    end
  end
end

module LikeBooksHelper
  def like_message book
    count = book.user_like_books.count
    if current_user.books.exists?(book.id)
      if book.user_like_books.count > 1
        return t("like.you") + (count - 1).to_s +
               t("like.people")
      end
      t("like.only_you")
    else
      count.to_s + t("like.people")
    end
  end
end

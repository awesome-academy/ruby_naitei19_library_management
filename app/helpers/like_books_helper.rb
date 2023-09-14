module LikeBooksHelper
  def like_message book
    if book.user_like_books.count > 1
      return t("like.you") + (book.user_like_books.count - 1).to_s +
             t("like.people")
    end

    t("like.only_you")
  end
end

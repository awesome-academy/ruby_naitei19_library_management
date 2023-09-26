module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def formatted_datetime datetime
    datetime.strftime("%H:%M %d/%m/%Y")
  end

  def display_errors_for object, field
    return unless object.errors[field].any?

    object.errors[field].join(", ")
  end
end

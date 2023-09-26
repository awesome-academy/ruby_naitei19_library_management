module FormHelper
  def show_errors object, field_name
    return unless object.errors.any?

    return if object.errors.messages[field_name].blank?

    object.errors.messages[field_name].join(", ").capitalize
  end
end

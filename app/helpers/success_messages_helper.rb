module SuccessMessagesHelper
  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def success_messages_for(*objects)
    options = objects.extract_options!
    options[:header_message] ||= "Success!"
    content_tag(:div, class: "alert alert-block alert-success") do
      content_tag(:h4, options[:header_message], class: "alert-heading") + content_tag(:p, flash["notice"])
    end
  end

end

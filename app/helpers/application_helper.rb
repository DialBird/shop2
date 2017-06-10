module ApplicationHelper
  def display_flash
    flash.each do |type, msg|
      type = 'danger' if type == 'alert'
      type = 'success' if type == 'notice'
      concat content_tag(:div, msg, class: "alert alert-#{type}")
    end
    nil
  end

  def display_errors(obj, properties = [], title: I18n.t(:title, scope: 'errors'), html_options: {})
    html_options.reverse_merge!(class: 'alert alert-danger alert-dismissable')
    messages = Array(obj).map do |o|
      properties.map { |p| o.errors.messages[p] }.compact
    end.flatten

    return if messages.blank?

    content_tag :div, html_options do
      concat content_tag(:i, content_tag(:strong, " #{title}"), class: 'fa fa-exclamation-circle')
      concat display_ul(messages)
    end
  end

  private

  def display_ul(messages)
    content_tag :ul do
      messages.each { |m| concat content_tag(:li, m) }
    end
  end
end

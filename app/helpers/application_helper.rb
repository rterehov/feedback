module ApplicationHelper

  def nav_link(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
        content_tag(:li, :class => "active") do
          link_to( text, link)
        end
    else
        content_tag(:li) do
          link_to( text, link)
        end
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def devise_error_messages_by_p!
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join.html_safe
  end

end

module ApplicationHelper
  def nav_link text, link, icon={}
    icon = {
      size: "1x"
    }.merge(icon)

    content = link_to icon[:type].present? ? fa_icon(icon[:type].to_s, text: text, class: icon[:size].to_s) : text, link

    if current_page? link
      content_tag :li, class: "active" do
        content
      end
    else
      content_tag(:li) do
        content
      end
    end
  end

  def flash_class(level)
    case level
    when "notice" then "message-info"
    when "success" then "message-success"
    when "error" then "message-danger"
    when "alert" then "message-danger"
    end
  end
end

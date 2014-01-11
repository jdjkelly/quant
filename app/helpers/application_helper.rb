module ApplicationHelper
  def nav_link text, link
    if current_page? link
      content_tag :li, class: "active" do
        link_to text, link
      end
    else
      content_tag(:li) do
        link_to text, link
      end
    end
  end
end

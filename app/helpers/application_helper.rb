module ApplicationHelper
  # returns full_page_title
  def full_title(page_title)
    base_title = "Chat App"
    return base_title if page_title.empty?
    "#{page_title} | #{base_title}"
  end
end

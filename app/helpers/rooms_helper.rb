module RoomsHelper
  def latest_message(room)
    msg = room.messages.last
    content_tag(:h4, msg.content, class: "content") if msg.present?
  end

  def posted_time_of_latest_message(room)
    msg = room.messages.last
    content_tag(:span, l(msg.created_at)) if msg.present?
  end
end

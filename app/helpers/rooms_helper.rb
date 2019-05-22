module RoomsHelper
  def render_latest_message(room)
    msg = room.messages.last
    if msg
      message = content_tag(:h4, msg.content)
      message += content_tag(:span, l(msg.created_at))
      message
    end
  end
end

module RoomsHelper
  def room_image(room)
    room.image.presence || "room/default-image.png"
  end

  def is_own_room?(room)
    room.user == current_user
  end
end

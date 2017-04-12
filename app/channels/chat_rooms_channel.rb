class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    tour = Tour.where(id: data['chat_room_id']).first

    if ToursUser.active.where(user: current_user, tour_id: data['chat_room_id'], kicked: false).first.present? || (tour.present?  && current_user ==  tour.owner || current_user.is_superuser == true)
      Message.create!(user: current_user, body: data['message'], tour_id: data['chat_room_id'])
    end
  end
end

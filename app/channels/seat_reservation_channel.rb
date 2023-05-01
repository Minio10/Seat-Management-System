# frozen_string_literal: true

class SeatReservationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'seat_reservation_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

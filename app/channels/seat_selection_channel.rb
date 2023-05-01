# frozen_string_literal: true

class SeatSelectionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'seat_selection_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # Process the received seat selection data
  end
end

# frozen_string_literal: true

class ReserveSeats
  Result = Struct.new(:success?, keyword_init: true)

  def initialize(seat_ids)
    @seat_ids = seat_ids
    @seats = nil
  end

  def perform
    find_seats
    Seat.transaction do
      reserve_seats
    end
    Result.new(success?: validate_seats)
  end

  private

  def find_seats
    @seats = Seat.lock.where(id: @seat_ids)
  end

  def reserve_seats
    @seats.update_all(status: :reserved)
  end

  def validate_seats
    return false if @seats.any? { |seat| !seat.valid? }

    send_broadcast
    true
  end

  def send_broadcast
    # Broadcast the updated seats to subscribers using Action Cable
    ActionCable.server.broadcast('seat_reservation_channel', { updated_seats: @seats })
  end
end

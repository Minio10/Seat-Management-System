# frozen_string_literal: true

class UpdateSeat
  Result = Struct.new(:success?, keyword_init: true)

  def initialize(seat_id, task, visitor_id)
    @seat_id = seat_id
    @task = task
    @visitor_id = visitor_id
    @seat = nil
  end

  def perform
    find_seat
    Seat.transaction do
      update_seat
    end
    send_broadcast if @seat.valid?
    Result.new(success?: @seat.valid?)
  end

  private

  def find_seat
    @seat = Seat.lock.find_by(id: @seat_id)
  end

  def update_seat
    if @task == 'select'
      # Update seats in the database
      @seat.update(status: :selected, visitor_id: @visitor_id)
    else
      @seat.update(status: :free, visitor_id: nil)
    end
  end

  def send_broadcast
    # Broadcast the updated seats to subscribers using Action Cable
    ActionCable.server.broadcast('seat_selection_channel', { updated_seats: @seat, task: @task })
  end
end

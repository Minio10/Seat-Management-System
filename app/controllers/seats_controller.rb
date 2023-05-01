class SeatsController < ApplicationController
  before_action :set_visitor_id

  # GET /seats
  def index
    @seats = Seat.all
  end

  # POST /seats/update_selected_seats
  def update_selected_seats
    selected_seats = params[:selected_seats]
    task = params[:task] 

    if task == 'reserve'
      Seat.where(id: selected_seats).update_all(status: :reserved)
    else  
      # Update seats in the database
      Seat.where(id: selected_seats).update_all(status: :selected, visitor_id: @visitor_id)
    end

    updated_seats = Seat.where(id: selected_seats)
    data = { updated_seats: updated_seats, task: task }

     # Broadcast the updated seats to subscribers using Action Cable
    ActionCable.server.broadcast('seat_selection_channel',  data )

    head :ok
  end

  private

  def set_visitor_id
    session[:visitor_id] ||= SecureRandom.uuid
    @visitor_id = session[:visitor_id]
  end
end

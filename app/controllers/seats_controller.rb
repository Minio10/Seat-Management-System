# frozen_string_literal: true

class SeatsController < ApplicationController
  before_action :set_visitor_id

  def index
    @seats = Seat.all
  end

  def update_selected_seats
    result = UpdateSeat.new(params[:seat], params[:task], @visitor_id).perform

    if result.success?
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def reserve_selected_seats
    result = ReserveSeats.new(params[:selected_seats]).perform
    if result.success?
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def set_visitor_id
    session[:visitor_id] ||= SecureRandom.uuid
    @visitor_id = session[:visitor_id]
  end
end

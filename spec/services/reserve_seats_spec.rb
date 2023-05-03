# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReserveSeats do
  let(:seat_ids) { [1, 2] }
  let!(:seat1) { Seat.create(id: seat_ids[0], row: 0, column: 1) }
  let!(:seat2) { Seat.create(id: seat_ids[1], row: 0, column: 2) }

  let(:reserve_seats) do
    described_class.new(seat_ids)
  end

  context 'when seats are reserved' do
    it 'updates the status of the seats' do
      result = reserve_seats.perform
      aggregate_failures do
        expect(seat1.reload.status).to eq('reserved')
        expect(seat2.reload.status).to eq('reserved')
        expect(result.success?).to be(true)
      end
    end
  end
end

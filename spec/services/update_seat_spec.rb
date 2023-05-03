# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSeat do
  let(:task) { 'select' }
  let(:visitor_id) { '5' }
  let!(:seat1) { Seat.create(id: 1, row: 0, column: 1) }

  let(:update_seat) do
    described_class.new(seat1.id, task, visitor_id)
  end

  context 'when seat is selected' do
    it 'updates the status of the seat and the visitor id' do
      result = update_seat.perform
      aggregate_failures do
        expect(seat1.reload.status).to eq('selected')
        expect(seat1.reload.visitor_id).to eq(visitor_id)
        expect(result.success?).to be(true)
      end
    end
  end

  context 'when seat is unselected' do
    let(:task) { 'unselect' }
    before do
      seat1.visitor_id = '5'
    end
    it 'updates the status of the seat and the visitor id' do
      result = update_seat.perform
      aggregate_failures do
        expect(seat1.reload.status).to eq('free')
        expect(seat1.reload.visitor_id).to eq(nil)
        expect(result.success?).to be(true)
      end
    end
  end
end

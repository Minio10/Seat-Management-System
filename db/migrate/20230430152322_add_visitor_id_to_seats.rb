class AddVisitorIdToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :visitor_id, :string
  end
end

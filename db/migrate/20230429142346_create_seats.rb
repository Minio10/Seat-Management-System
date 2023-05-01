# frozen_string_literal: true

class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.integer :row
      t.integer :column
      t.integer :status, default: 0
      t.boolean :selected_by_current_user, default: false, null: false
      t.timestamps
    end
  end
end

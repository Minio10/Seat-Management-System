# frozen_string_literal: true

class MultipleChangesSeat < ActiveRecord::Migration[7.0]
  def change
    remove_column :seats, :selected_by_current_user, :boolean
    change_column_null :seats, :column, false
    change_column_null :seats, :row, false
    change_column_null :seats, :status, false
  end
end

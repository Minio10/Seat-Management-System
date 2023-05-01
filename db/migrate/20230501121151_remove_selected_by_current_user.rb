# frozen_string_literal: true

class RemoveSelectedByCurrentUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :seats, :selected_by_current_user, :boolean
  end
end

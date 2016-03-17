class AddConfirmedDefaultToEvents < ActiveRecord::Migration
  def change
    change_column :events, :confirmed, :boolean, :default => false
  end
end

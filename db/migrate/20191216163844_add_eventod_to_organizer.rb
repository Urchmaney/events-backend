class AddEventodToOrganizer < ActiveRecord::Migration[6.0]
  def change
    add_column :organizers, :event_id, :integer
  end
end

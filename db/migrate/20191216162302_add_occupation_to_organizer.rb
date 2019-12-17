class AddOccupationToOrganizer < ActiveRecord::Migration[6.0]
  def change
    add_column :organizers, :occupation, :string
  end
end

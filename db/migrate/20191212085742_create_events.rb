class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.string :location

      t.timestamps
    end
  end
end

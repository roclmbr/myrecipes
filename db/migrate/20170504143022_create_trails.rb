class CreateTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :trails do |t|
        t.string :trailname
        t.text   :description
        t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :place_id
      t.string :name
      t.string :city
      t.string :country
      t.decimal :latitude, :precision => 16, :scale => 13
      t.decimal :longitude, :precision => 16, :scale => 13
      t.integer :users_count, default: 0, null: false
      t.timestamps
    end
    add_reference :users, :location
  end
end

class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :country
      t.string :latitude
      t.string :longitude
      t.string :gmaps

      t.timestamps
    end
  end
end

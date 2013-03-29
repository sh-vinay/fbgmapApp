class City < ActiveRecord::Base
  attr_accessible :country, :gmaps, :latitude, :longitude, :name, :state
  acts_as_gmappable :position => :location
  field :location, :type => Array

  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.integer :population
      t.timestamps
    end
  end

end

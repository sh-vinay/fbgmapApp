class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @json = Location.all.to_gmaps4rails
    
    # @cities = Hash.new { |hash, key| hash[key] = {} }
    #     @cities[:name] = "New Delhi"
    #     @cities[:country] = "India"
    #     @cities = @cities.to_json
    # @json = @cities.to_gmaps4rails   

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end
end

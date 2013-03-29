class Location < ActiveRecord::Base
    include Gmaps4rails::ActsAsGmappable
    attr_accessible :name, :address, :longitude, :latitude
   	acts_as_gmappable 
       
    def gmaps4rails_address
          "#{self.name}, #{self.address}" 
    end
      
    def gmaps4rails_infowindow
         "<h6>#{name}</h6>" << "<h6>#{address}</h6>"
    end

    def self.convert_to_city_address(cities)  
      cities.map{|c| 
        geocode = Gmaps4rails.geocode(c[0])
        new( :name => c[0], :address => c[1][:state], :latitude => geocode[0][:lat], :longitude => geocode[0][:lng])
      }  	
    end

    def process_geocoding
        true
    end

end
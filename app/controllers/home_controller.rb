class HomeController < ApplicationController
 
  def index
  	# if session[:credentials].present?  		
		# user = FbGraph::User.me(session[:credentials]["token"])
  	if session[:credentials].present?
       @graph = Koala::Facebook::API.new(session[:credentials]["token"])
  		 @profile = @graph.get_object("me")
  		 # @friends = get_friends_location(@graph.get_connections("me", "friends"))
  		 @friends = get_friends_location(@graph.get_connections("me", "friends", :fields=>"name, location, hometown"))
       # @friends = @graph.get_connections("me", "friends", :fields=>"name, location, hometown")
       # @user_permissions = @graph.get_connections('me','permissions')
       @cities = Hash.new { |hash, key| hash[key] =  Hash.new }
       
       @friends.each do |key, value|
        
          if value["location"].present? || value["hometown"].present?
          
            if value["location"].present?
              address = value["location"].split(",")
             if(@cities.has_key?(address[0]))  
                @cities[address[0]][:count] =  @cities[address[0]][:count] + 1
              else
                @cities[address[0]][:count] = 1
                @cities[address[0]][:state] =  address[1]
              end   
            else    
              if value["hometown"].present?
                address = value["hometown"].split(",")
                if(@cities.has_key?(address[0]))  
                  @cities[address[0]][:count] =  @cities[address[0]][:count] + 1
                  else
                  @cities[address[0]][:count] = 1
                  @cities[address[0]][:state] =  address[1]
                end     
              end
            end  
          end  
        end
  
        @cities = @cities.sort_by {|k,v| v[:count]}.reverse
        @json = Location.convert_to_city_address(@cities).to_gmaps4rails 

      respond_to do |format|
			format.html
			format.json{
			render :json => @friends_hash.to_json
			}
		end
       
 	end	
  end
 
	def get_friends_location(friends)
	  friends_hash = Hash.new { |hash, key| hash[key] = {} } 
     
      friends.each do |friend|
          location_hash = Hash.new { |hash, key| hash[key] = {} }
          if friend["location"].present?
            location_hash["location"] = friend["location"]["name"]
          if friend["hometown"].present?
            location_hash["hometown"] = friend["hometown"]["name"]
          end
        end  
        friends_hash[friend["id"]] = location_hash
    end
	  return friends_hash
	end	

  
end 

class DemoController < ApplicationController
  
  #require 'api_provider/room_manager'

  require 'fetcher'

  def index
  	props_string = Fetcher.get_properties
  	request_data = process_data(props_string)
  	@response = Room.save_data(request_data)

  	if @response
  		#further processing
  	end


  end


private
   def process_data(props_string)

   	
   	props_hash = JSON.parse(props_string)

   	rooms = Array.new

   	if props_hash["properties"].kind_of?(Array) && props_hash["properties"].count.to_i > 0
   		props_hash["properties"].each do |property|
   			room = Room.new(
   				:address => property['property_address'], 
   				:apartment_number => property['apartment_no'], 
   				:postal_code => property['zip_code'],	
   				:city => property['town'],
  				:country => property['country'],
   				:description => property['property_description'], 
   				:number_of_bedrooms => property['bedrooms_no'],
   				:max_guests => property['max_people'],
   				:internal_id => property['source_id']
   				)

   			if room.valid?
   				rooms << room
   			else
   				Rails.logger.info "Invalid room data supplied"
   				raise "Invalid room data supplied"
   			end
   		end
   	end

  	Rails.logger.info "Processed data.."

    return rooms
  
  end

  



end

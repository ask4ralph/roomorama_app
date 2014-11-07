class Room
  include ActiveAttr::Model
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment


  attribute :address
  attribute :apartment_number
  attribute :postal_code
  attribute :city
  attribute :country 
  attribute :description   
  attribute :number_of_bedrooms
  attribute :max_guests
  attribute :internal_id
  
  attr_accessor  :address, :apartment_number, :postal_code, :city, :country, :description, :number_of_bedrooms, :max_guests, :internal_id 

  #add custom validation
  validates_presence_of :address, :apartment_number, :postal_code, :city, :country, :description, :number_of_bedrooms, :max_guests, :internal_id 
  validates_length_of :address, :maximum => 100


  def self.save_data(data)


    api_url = "http://www.example.com/api/v1/rooms"

     headers = {
          :content_type => :json,
          :accept => :json,
          "Authorization" => "secret_token1989"
      }

    begin
        rooms_data = data.to_json
          response = RestClient.post(api_url, rooms_data, headers
      ) { |response, request, result, &block|
        logger.info ">>> Response code " + response.code.to_s
        logger.info ">>> Response message " + response

        return response
        case response.code
          when 201#rooms created
            #@resp = JSON.parse(response)
            return "Rooms successfully created"
          #when 500

          else
            return "Error occured. Response code #{response.code.to_s}"
          end
      }
    rescue => e
      Rails.logger.info "An error occured.. #{e.message}"
      return "An error occured.. #{e.message}"
    end



  end

  
end
require 'rails_helper'

RSpec.describe DemoController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the room data into rooms" do
      demo_controller = DemoController.new
      data = Fetcher.get_properties
      rooms = demo_controller.send(:process_data, data)

   	  hash_data = JSON.parse(data)
   	  first_element = hash_data["properties"].first
   	  first_room = rooms[0]
      expect(first_element['property_address']).to eq(first_room.address)
      expect(first_element['apartment_no']).to eq(first_room.apartment_number)
      expect(first_element['zip_code']).to eq(first_room.postal_code)
      expect(first_element['town']).to eq(first_room.city)
      expect(first_element['country']).to eq(first_room.country)
      expect(first_element['bedrooms_no']).to eq(first_room.number_of_bedrooms)
      expect(first_element['max_people']).to eq(first_room.max_guests)
      expect(first_element['source_id']).to eq(first_room.internal_id)
    end



  end

end

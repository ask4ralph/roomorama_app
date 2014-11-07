class DemoController < ApplicationController
  
  require 'api_provider/room_manager'

  def index
  	dat = "The data is here oo."
  	RoomManager.process_data(dat)
  end

   def process_data(data)

  	Rails.logger.info "Processing data..."

  	Rails.logger.info data

  end


end

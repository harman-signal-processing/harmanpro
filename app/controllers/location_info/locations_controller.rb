class LocationInfo::LocationsController < ApplicationController
    respond_to :json
    
    def countries
        respond_with LocationInfo::Country.all
    end
    
end  #  class LocationInfo::LocationsController < ApplicationController
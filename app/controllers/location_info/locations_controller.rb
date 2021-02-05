class LocationInfo::LocationsController < ApplicationController

  def countries
    render json: {"locations" => LocationInfo::Country.all}
  end

end  #  class LocationInfo::LocationsController < ApplicationController

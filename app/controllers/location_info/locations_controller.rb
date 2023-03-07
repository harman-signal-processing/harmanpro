class LocationInfo::LocationsController < ApplicationController

  def countries
    render json: {"locations" => LocationInfo::Country.all.where.not(alpha2:["CU","IR","RU"])}
  end

end  #  class LocationInfo::LocationsController < ApplicationController

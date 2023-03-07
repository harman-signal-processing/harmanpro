class LocationInfo::LocationsController < ApplicationController

  def countries
    render json: {"locations" => LocationInfo::Country.all.where.not(alpha2:["CU","IR", "KP", "RU", "SY"])}
  end

end  #  class LocationInfo::LocationsController < ApplicationController

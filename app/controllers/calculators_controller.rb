class CalculatorsController < ApplicationController

  def cinema
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
  end

end

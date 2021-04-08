module ServiceCentersHelper

  def custom_sorted_service_centers
    @service_centers.sort_by{|a|
      [
        # customer rating desc, make nils zeros
        -(a.customer_rating||0),
        # group count desc
        -(a.service_center_service_groups.count),
        # name asc
        a.name
      ]
    }  #  @service_centers.sort_by{|a|
  end  #  def custom_sorted_service_centers

end  #  module ServiceCentersHelper

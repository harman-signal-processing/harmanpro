module ServiceCentersHelper

  def custom_sorted_service_centers
    @service_centers.sort{|a,b|
      # customer rating desc, make nils zeros
      4 * (b.customer_rating||0 <=> a.customer_rating||0) + 
      # group count desc
      2 * (b.service_center_service_groups.count <=> a.service_center_service_groups.count) + 
      # name asc
      (a.name <=> b.name)
    }
  end  #  def custom_sorted_service_centers

end  #  module ServiceCentersHelper
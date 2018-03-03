class Emea::DistributorsController < EmeaController
  respond_to :json

  # Returns all countries
  def countries
    respond_with Distributor.order(:country).pluck(:country).uniq
  end

  # Returns all the brands
  def brands
    respond_with Brand.all_for_site.order(:name)
  end

  # All the distributors for a given country/brand
  def distributors
    brand = Brand.find(params[:brand_id])

    respond_with brand.distributors.where(
      country: params[:country_id]
    ).order("name")
  end

end


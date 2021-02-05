class Emea::DistributorsController < EmeaController

  # Returns all countries
  def countries
    respond_to do |format|
      format.json { render json: { "distributors" => Distributor.order(:country).pluck(:country).uniq } }
    end
  end

  # Returns all the brands
  def brands
    respond_to do |format|
      format.json { render json: { "brands" => Brand.all_for_site.order(:name) } }
    end
  end

  # All the distributors for a given country/brand
  def distributors
    brand = Brand.find(params[:brand_id])

    distributors = brand.distributors.where(
      country: params[:country_id]
    ).order(Arel.sql("name"))

    respond_to do |format|
      format.json { render json: { "distributors" => distributors } }
    end
  end

end


module MediaCoverageHelper

  def brands_with_media_coverage
    Brand.where(id: BrandMediaCoverage.unique_brand_ids).order("UPPER(name)")
  end

  def brand_link_name_for_media_coverage_sidebar(brand)
    "#{ brand.name } (#{ number_with_delimiter brand.media_coverages.live.size })"
  end

  def all_link_name_for_media_coverage_sidebar
    "#{ t('all').titleize } (#{ number_with_delimiter MediaCoverage.live.length })"
  end
end

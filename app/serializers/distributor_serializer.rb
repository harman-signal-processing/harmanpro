class DistributorSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :country,
    :channel_manager,
    :contact_name,
    :contact_phone,
    :contact_email,
    :time_zone,
    :details_public,
    :details_private,
    :region,
    :website,
    :brand_names

  def brand_names
    object.brands.order(:name).pluck(:name)
  end

  def website
    object.website.to_s.match(/www|http/i) ? format_link(object.website) : nil
  end

  def format_link(url)
    url.to_s.match(/^http/i) ? url : "http://#{url}"
  end
end


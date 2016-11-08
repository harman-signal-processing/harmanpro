class VerticalMarketSerializer < ActiveModel::Serializer
  attributes :id, :name, :headline, :description, :banner_url, :slug, :parent_id
  has_many :reference_systems

  def banner_url
    ActionController::Base.helpers.asset_path object.banner.url(:large)
  end

  def reference_systems
    object.featured_reference_systems
  end
end

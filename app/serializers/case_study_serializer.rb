class CaseStudySerializer < ActiveModel::Serializer
  attributes :id,
    :headline,
    :slug,
    :banner_url,
    :small_panel_banner_url,
    :published_on

  def banner_url
    object.banner.present? ? expanded_banner_url(:medium) : nil
  end

  def small_panel_banner_url
    object.banner.present? ? expanded_banner_url(:small_panel) : nil
  end

  def published_on
    I18n.l(object.created_at.to_date, format: :long)
  end

  private

  def expanded_banner_url(size="original")
    ActionController::Base.helpers.asset_path object.banner.url(size)
  end
end

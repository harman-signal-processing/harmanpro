class CaseStudySerializer < ActiveModel::Serializer
  attributes :id,
    :created_at,
    :updated_at,
    :banner_file_name,
    :banner_content_type,
    :banner_file_size,
    :banner_updated_at,
    :pdf_file_name,
    :pdf_content_type,
    :pdf_file_size,
    :pdf_updated_at,
    :pdf_external_url,
    :youtube_id,
    :headline,
    :slug,
    :banner_url,
    :small_panel_banner_url,
    :description,
    :content,
    :published_on,
    :banner_urls,
    :pdf_url,
    :youtube_info

  has_many :vertical_markets, serializer: VerticalMarketShortSerializer
  has_many :translations

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

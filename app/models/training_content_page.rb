class TrainingContentPage < ActiveRecord::Base
translates :slug, :title, :subtitle, :main_content, :left_content, :right_content, :sub_content, :description
  extend FriendlyId
  friendly_id :title, use: :globalize

  belongs_to :original_locale, class_name: "AvailableLocale"

  has_attached_file :banner,
    styles: {
      large: "1170x400",
      medium: "500x200",
      small: "250x100",
      thumb: "83x50",
      thumb_square: "64x64#"
  }, default_url: "missing/banners/:style.jpg"
  attr_accessor :delete_banner

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
  validates :title, presence: true
  validates :main_content, presence: true

  before_save :assign_locale
  before_update :delete_banner_if_needed

  def delete_banner_if_needed
    unless self.banner.dirty?
      if self.delete_banner.present? && self.delete_banner.to_s == "1"
        self.banner = nil
      end
    end
  end

  def assign_locale
    self.original_locale ||= AvailableLocale.default
  end

  def side_column_width
    3
  end

  def main_content_width
    mcw = 9
    #mcw -= side_column_width if self.left_content.present?
    mcw -= side_column_width if self.right_content.present?
    mcw
  end    
end

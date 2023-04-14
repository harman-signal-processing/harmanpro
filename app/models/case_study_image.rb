class CaseStudyImage < ApplicationRecord
  belongs_to :case_study
  acts_as_list scope: :case_study_id

  has_attached_file :image,
    styles: {
      large_1700: "1700x980#",
      large_1700_2x: "3400x1960#",
      medium_860: "860x585#",
      medium_860_2x: "1720x1170#",
      small_200: "200x180#",
      small_200_2x: "400x360",
      thumb: "83x50#",
      thumb_square: "64x64#"
  }, processors: [:thumbnail, :compression],
  default_url: "missing/banners/:style.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def image_urls
    hash = {}
    hash[:original] = image.url(:original)
    hash[:large_1700] = image.url(:large_1700)
    hash[:large_1700_2x] = image.url(:large_1700_2x)
    hash[:medium_860] = image.url(:medium_860)
    hash[:medium_860_2x] = image.url(:medium_860_2x)
    hash[:small_200] = image.url(:small_200)
    hash[:small_200_2x] = image.url(:small_200_2x)
    hash[:thumb] = image.url(:thumb)
    hash[:thumb_square] = image.url(:thumb_square)
    hash
  end

end

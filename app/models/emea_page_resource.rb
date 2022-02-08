class EmeaPageResource < ApplicationRecord
  belongs_to :emea_page
  has_attached_file :attachment

  validates :name, presence: true
  validates :emea_page, presence: true
  validates :attachment, attachment_presence: true
  do_not_validate_attachment_file_type :attachment

  after_initialize :fill_empty_name

  def fill_empty_name
    self.name = attachment_file_name if self.name.blank?
  end

end

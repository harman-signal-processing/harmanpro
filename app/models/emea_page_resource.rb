class EmeaPageResource < ApplicationRecord
  belongs_to :emea_page
  has_attached_file :attachment

  validates :emea_page, presence: true
  validates :attachment, attachment_presence: true
  do_not_validate_attachment_file_type :attachment

end

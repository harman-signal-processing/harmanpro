class Influencer < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true

  has_attached_file :social_media_deck
  do_not_validate_attachment_file_type :social_media_deck

  # rails 7.1 raises errors with these serializers. They should be fine, but
  # we don't even use the Influencer model anymore. Commenting out to avoid
  # errors. (AA Feb 2024)
  #serialize :active_networks, coder: YAML, type: Array
  #serialize :type_of_content, coder: YAML, type: Array
  #serialize :define_your_content, coder: YAML, type: Array
  #serialize :harman_brands_for_collaborating, coder: YAML, type: Array

  before_save :fix_arrays

  def fix_arrays
    self.active_networks.reject!(&:blank?)
    self.type_of_content.reject!(&:blank?)
    self.define_your_content.reject!(&:blank?)
    self.harman_brands_for_collaborating.reject!(&:blank?)
  end
end

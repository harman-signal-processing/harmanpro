class Influencer < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true

  has_attached_file :social_media_deck
  do_not_validate_attachment_file_type :social_media_deck

  serialize :active_networks, Array
  serialize :type_of_content, Array
  serialize :define_your_content, Array
  serialize :harman_brands_for_collaborating, Array

  before_save :fix_arrays

  def fix_arrays
    self.active_networks.reject!(&:blank?)
    self.type_of_content.reject!(&:blank?)
    self.define_your_content.reject!(&:blank?)
    self.harman_brands_for_collaborating.reject!(&:blank?)
  end
end

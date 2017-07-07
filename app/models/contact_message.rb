class ContactMessage < ApplicationRecord
  before_validation :set_defaults
  belongs_to :brand

  validates :brand, presence: true
  validates :name, :subject, :message_type, presence: true
  validates :email, presence: true, email: true
  validates :message, presence: true, if: :support?
  validates :product, presence: true, if: :require_product?
  validates :shipping_country, presence: true, if: :require_country?
  validates :product_serial_number,
    :purchased_on, presence: true, if: :repair_request?
  validates :shipping_address,
    :shipping_city,
    :shipping_state,
    :shipping_zip, presence: true, if: :require_shipping_address?
  validates :warranty, inclusion: {in: [true, false]}, if: :repair_request?

  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

  after_create :create_message

  def self.message_types
    [
      ["Technical Support", "tech_support"],
      ["Product Parts", "parts_request"],
      ["Product Repair", "repair_request"]
    ]
  end

  def set_defaults
    self.subject ||= "Technical Support Request" if self.support?
    self.subject ||= "Parts Request" if self.part_request?
    self.subject ||= "Repair Request" if self.repair_request?
    self.email.to_s.gsub!(/\s*$/, '')
  end

  def create_message
    ServiceMailer.contact_form(self).deliver_later(wait: 5.minutes)
  end

  def require_product?
    support? || repair_request?
  end

  def require_country?
    support?
  end

  def require_shipping_address?
    part_request? || repair_request?
  end

  def support?
    !!(self.message_type.to_s.match(/support/i))
  end

  def part_request?
    !!(self.message_type.to_s.match(/part/i))
  end

  def repair_request?
    !!(self.message_type.to_s.match(/rma|repair/i))
  end

  def recipient
    @recipient ||= determine_recipient
  end

  private

  def determine_recipient
    if part_request?
      brand.parts_email
    elsif repair_request?
      brand.repair_email
    else
      brand.tech_support_email
    end
  end

end

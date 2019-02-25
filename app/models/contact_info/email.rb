class ContactInfo::Email < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
    
  has_many :email_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_email_id", class_name: 'ContactInfo::ContactEmail'
  has_many :contacts, through: :email_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
end

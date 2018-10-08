class MediaLibraryAccessRequest < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :company, presence: true
  validates :job_title, presence: true
  validates :relationship, presence: true
  validates :reason_for_request, presence: true
  validates :what_assets, presence: true

  after_create :send_access_request

  def send_access_request
    MediaLibraryMailer.access_request(self).deliver_later
  end
end

class LeadFollowup < ApplicationRecord
  validates :recipient_id, presence: true
  validates :note, presence: true
end

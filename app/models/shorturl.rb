class Shorturl < ApplicationRecord
  validates :shortcut, presence: true, uniqueness: { case_sensitive: false }
  validates :full_url, presence: true
end

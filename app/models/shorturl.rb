class Shorturl < ApplicationRecord
  validates :shortcut, presence: true, uniqueness: true
  validates :full_url, presence: true
end

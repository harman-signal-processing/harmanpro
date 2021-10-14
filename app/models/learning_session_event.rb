class LearningSessionEvent < ApplicationRecord
  attribute :sessions

  has_many :learning_session_event_sessions, dependent: :destroy, inverse_of: :learning_session_event
  has_many :learning_session_event_brands, dependent: :destroy, inverse_of: :learning_session_event
  has_many :brands, through: :learning_session_event_brands


  accepts_nested_attributes_for :learning_session_event_sessions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :learning_session_event_brands, reject_if: :all_blank, allow_destroy: true

end  #  class LearningSessionEvent < ApplicationRecord

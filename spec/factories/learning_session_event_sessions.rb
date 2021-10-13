FactoryBot.define do
  factory :learning_session_event_session do
    title { "learning session event session title" }
    session_date { "2021-10-01" }
    session_times { "session times" }
    register_link { "session registration link" }
    learning_session_event
  end
end

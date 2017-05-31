FactoryGirl.define do
  factory :project_update do
    project
    sequence(:amount) { |n| n }
    recorded_time {Time.now.to_i}
  end
end

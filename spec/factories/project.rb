FactoryGirl.define do
  factory :project do
    company
    sequence(:name) { |n| "Project-Name-{n}" }
    funding_amount {rand(56000..99000)}
    city "Berlin"
    developer "The same developer"
    duration_in_months {rand(46..77)}
    interest_rate '5.34'

    after(:create) do |project|
      create(:project_update, project_id: project.id)
    end
  end
end

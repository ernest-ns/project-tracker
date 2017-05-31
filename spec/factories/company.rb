FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Company-#{n}" }

    after(:create) do |company|
      create(:project, company_id: company.id)
    end
  end
end

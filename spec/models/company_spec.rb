require 'rails_helper'

describe Company do

  let(:company) { FactoryGirl.create(:company) }
  let(:project_1) { company.projects.first }
  let(:project_2) { FactoryGirl.create(:project, {name: "project-2-#{rand(10)}", company_id: company.id}) }
  let(:project_1_update_1) { project_1.project_updates.first }
  let(:project_2_update_1) { project_2.project_updates.first }

  describe "#total_funding" do
    it "returns the total funding received across projects" do
      expected_total = project_1_update_1.amount + project_2_update_1.amount

      expect(company.total_funding).to eql(expected_total)
    end
  end
end

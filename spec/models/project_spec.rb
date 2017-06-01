require 'rails_helper'

describe Project do

  let(:company) { FactoryGirl.create(:company) }
  let(:project) { company.projects.first }
  let(:project_update_1) { project.project_updates.first }

  describe "#funding_so_far" do
    it "returns the total funding received" do
      project_update_2 = FactoryGirl.create(:project_update, {project_id: project.id})
      expect(project.funding_so_far).to eql(project_update_1.amount + project_update_2.amount)
    end
  end

  describe "#fully_funded?" do
    it "return false if the project is not fully funded" do
      expect(project.fully_funded?).to eql(false)
    end

    it "returns true if the project is fully funded" do
      remaning_amount = project.funding_amount - project.funding_so_far
      FactoryGirl.create(:project_update, {project_id: project.id, amount: remaning_amount})

      expect(project.fully_funded?).to eql(true)
    end
  end

  describe "time_taken_so_far" do
    it "return the total time taken" do
      project_update_2 = FactoryGirl.create(:project_update, {project_id: project.id, recorded_time: Time.now + 1.day})
      expect(project.time_taken_so_far).to eql((project_update_2.recorded_time - project_update_1.recorded_time).to_i)
    end
  end
end

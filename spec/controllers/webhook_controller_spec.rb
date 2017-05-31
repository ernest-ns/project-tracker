require 'rails_helper'

RSpec.describe WebhookController, type: :controller do

  describe "POST #add_data" do

    it "returns http success" do
      post :add_data, :params => generate_params
      expect(response).to have_http_status(:success)
      expect(ProjectUpdate.last.amount).to eql(56231)
    end

    it "does not create duplicates" do
      company = FactoryGirl.create(:company)
      project = company.projects.first
      project_update = project.project_updates.first


      post :add_data, :params => generate_params(company.name, project.name)
      expect(response).to have_http_status(:success)
      expect(ProjectUpdate.where(project_id: project.id).count).to eql(2)
    end
  end

  def generate_params(company = "Company A", project = "Project A")
    {
        "project" => project,
        "platform" => company,
        "project_details" => {
          "funding_amount" => 500000,
          "city" => "Berlin",
          "developer" => "Developer A",
          "duration_in_months" => 24,
          "interest_rate" => "5.25"
        },
        "capture_details" => {
          "time" => 1493643600000,
          "amount" => 56231
        }
      }
  end

end

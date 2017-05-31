class WebhookController < ApplicationController
  def add_data
    company = Company.where(name: params[:platform]).first_or_create
    project = Project.where(name: params[:project]).first_or_create do |new_project|
      new_project.company_id =  company.id
      new_project.funding_amount =  params[:project_details][:funding_amount]
      new_project.city =  params[:project_details][:city]
      new_project.developer =  params[:project_details][:developer]
      new_project.duration_in_months =  params[:project_details][:duration_in_months]
      new_project.interest_rate =  params[:project_details][:interest_rate]
    end

    ProjectUpdate.create({project_id: project.id, amount: params[:capture_details][:amount], recorded_time: params[:capture_details][:time]})
  end
end

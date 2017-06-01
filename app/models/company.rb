class Company < ApplicationRecord
  has_many :projects

  def total_funding
    project_ids = self.projects.pluck(:id)
    query = "Select sum(project_updates.amount) FROM project_updates WHERE project_updates.project_id IN  (#{project_ids.join(",")})"
    results = ActiveRecord::Base.connection.exec_query(query)
    results[0]["sum"]
  end
end

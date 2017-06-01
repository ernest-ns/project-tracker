class Project < ApplicationRecord
  has_many :project_updates
  belongs_to :company

  def funding_so_far
    query = "Select sum(project_updates.amount) FROM project_updates WHERE project_updates.project_id = #{self.id}"
    results = ActiveRecord::Base.connection.exec_query(query)
    results[0]["sum"]
  end

  def fully_funded?
    (funding_so_far == self.funding_amount)
  end

  def time_taken_so_far
    results = ProjectUpdate.where(project_id: self.id).order(:recorded_time)
    (results.last.recorded_time - results.first.recorded_time).to_i
  end

  def daily_progress
    query = "SELECT DISTINCT recorded_time, amount - LAG(amount) OVER (ORDER BY recorded_time) as progress FROM project_updates WHERE project_id = #{self.id} ORDER BY recorded_time ASC;"
    ActiveRecord::Base.connection.exec_query(query)
  end


  def human_readable_total_time_taken
    ChronicDuration.output(time_taken_so_far, :format => :short)
  end
end

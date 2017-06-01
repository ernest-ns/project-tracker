class AnswersController < ApplicationController
  helper_method :humanize

  def index
    @fully_funded_project = Project.last
    @not_yet_funded_project = Project.first
    @projects = [@not_yet_funded_project, @fully_funded_project]
  end
end

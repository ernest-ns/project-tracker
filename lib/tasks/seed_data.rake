namespace :seed_data do
  desc "Generate Company Data"
  task generate_company_data: :environment do
    puts "Generating Company data"
    company_names = ["Company A", "Company B"]

    company_names.each do |company_name|
      Company.where(name: company_name).first_or_create
    end
    puts "Done Generating Company Data"
  end

  desc "Generate Projects for companies"
  task :generate_projects_data => [:generate_company_data, :environment] do
    puts "Generating Project Data"
    first_company = Company.first
    second_company = Company.last

    project_names_first_company = ["Project 1", "Project 2", "Project 3"]
    project_names_second_company = ["Project 10", "Project 9", "Project 8"]
    developers = ["Developer 1", "Developer 2", "Developer 3", "Developer 4", "Developer 5", "Developer 6"]
    cities = ["Frankfurt", "Berlin", "Munich", "Hamburg"]

    project_names_first_company.each do |project_name|
      p = Project.where(name: project_name).first_or_create do |project|
        project.company_id = first_company.id
        project.funding_amount = rand(50000..150000)
        project.city = cities.sample
        project.developer = developers.sample
        project.duration_in_months = rand(12..48)
        project.interest_rate = "5.25"
      end
    end

    project_names_second_company.each do |project_name|
      Project.where(name: project_name).first_or_create do |project|
        project.company_id = second_company.id
        project.funding_amount = rand(500000..1500000)
        project.city = cities.sample
        project.developer = developers.sample
        project.duration_in_months = rand(12..48)
        project.interest_rate = "5.25"
      end
    end
    puts "Done Generating Project Data"
  end

  desc "Generate Project Updates"
  task :generate_project_updates_data => [:generate_company_data, :generate_projects_data, :environment] do
    puts "Generating Project Updates"
    Company.first.projects.each do |project|
      start_time = Time.now - rand(2..5).years
      recorded_time = start_time
      funding_sequence = generate_random_funding_amounts(project.funding_amount)
      funding_sequence.each do |amount|
        recorded_time = recorded_time + 86400
        ProjectUpdate.create({project_id: project.id, recorded_time: (recorded_time), amount: amount})
      end
    end

    Company.last.projects.each do |project|
      start_time = Time.now - rand(2..5).years
      recorded_time = start_time
      funding_sequence = generate_random_funding_amounts(project.funding_amount)
      funding_sequence.each do |amount|
        recorded_time = recorded_time + 86400
        ProjectUpdate.create({project_id: project.id, recorded_time: (recorded_time), amount: amount})
      end

      recorded_time = recorded_time + 86400
      remaning_amount = project.funding_amount - project.funding_so_far
      ProjectUpdate.create({project_id: project.id, recorded_time: (recorded_time), amount: remaning_amount})
    end

    puts "Done Generating Project Updates"
  end

  desc "Generates Company, Project and Project Updates"
  task :generate_data => [:generate_company_data, :generate_projects_data, :generate_project_updates_data, :environment] do
    puts "Done Generating Data"
  end
end

def generate_random_funding_amounts(max)
  sequence = [0]
  1.upto(100) do |x|
    random_number = x*rand(10..25)
    break if random_number > max
    sequence[x] = sequence[x-1] + random_number
  end
  sequence
end

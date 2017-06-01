namespace :seed_data do
  desc "Generates Company, Project and Project Updates"
  task generate_data: :environment do
    company_names = ["Meh", "Blah"]

    company_names.each do |company_name|
      Company.where(name: company_name).first_or_create
    end
    first_company = Company.first
    second_company = Company.last

    project_names_first_company = ["Project 1", "Project 2", "Project 3"]
    project_names_second_company = ["Project 10", "Project 9", "Project 8"]
    developers = ["Developer 1", "Developer 2", "Developer 3", "Developer 4", "Developer 5", "Developer 6"]
    cities = ["Frankfurt", "Berlin", "Munich", "Hamburg"]

    project_names_first_company.each do |project_name|
      p = Project.where(name: project_name).first_or_create do |project|
        project.company_id = first_company.id
        project.funding_amount = rand(500000..1500000)
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
  end
end

def generate_random_funding_amounts(max)
  sequence = Array.new
  1.upto(100) do |x|
    random_number = x*rand(50..100)
    break if random_number > max
    sequence[x] = random_number
  end
  sequence
end

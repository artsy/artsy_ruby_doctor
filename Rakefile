require "rspec/core/rake_task"
require "standard/rake"
require "json"
require "./lib/project_loader"
require "./lib/ruby_exam"

desc "Clone projects for examination"
task :load_projects do
  data = File.read("data/projects.json")
  json = JSON.parse(data)
  project_names = json["projects"].map { |project| project["name"] }
  ProjectLoader.load_all(project_names)
end

desc "Examine projects"
task examine: :load_projects do
  data = File.read("data/projects.json")
  json = JSON.parse(data)
  project_names = json["projects"].map { |project| project["name"] }

  ruby_exams = project_names.map do |project_name|
    RubyExam.from_repo(project_name)
  end

  ruby_exams.each do |exam|
    puts exam.to_csv
  end
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]

require "json"
require "./lib/project_loader"
require "./lib/ruby_project"

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

  ruby_projects = project_names.map do |project_name|
    RubyProject.from_repo(project_name)
  end

  ruby_projects.each do |project|
    puts project.to_csv
  end
end

require "json"
require "./lib/project_loader"

desc "Clone projects for examination"
task :load_projects do
  data = File.read("data/projects.json")
  json = JSON.parse(data)
  project_names = json["projects"].map { |project| project["name"] }
  ProjectLoader.load_all(project_names)
end

desc "Examine projects"
task :examine do
  puts "ok"
end

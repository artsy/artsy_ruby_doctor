require "rspec/core/rake_task"
require "standard/rake"
require "csv"
require "json"
require "./lib/project_loader"
require "./lib/ruby_exam"
require "./lib/ruby_project"

desc "Clone projects for examination"
task :clone_projects do
  ProjectLoader.clone_all
end

desc "Examine projects"
task :examine do
  projects = ProjectLoader.load_all

  projects.each do |project|
    default_output = {name: project.name}
    exam = RubyExam.new(project)
    results = exam.results
    output = default_output.merge(results).values.to_csv
    puts output
  end
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]

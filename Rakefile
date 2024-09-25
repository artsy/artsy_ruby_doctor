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

  ruby_exams = projects.map do |project|
    RubyExam.new(project)
  end

  ruby_exams.each do |exam|
    puts exam.results.values.to_csv
  end
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]

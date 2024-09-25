require "rspec/core/rake_task"
require "standard/rake"
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
  project_names = projects.map(&:name)

  ruby_exams = project_names.map do |project_name|
    RubyExam.from_repo(project_name)
  end

  ruby_exams.each do |exam|
    puts exam.to_csv
  end
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]

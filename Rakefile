require "rspec/core/rake_task"
require "standard/rake"
require "./lib/artsy_ruby_doctor"

desc "Clone projects for examination"
task :clone_projects do
  ProjectLoader.clone_all
end

desc "Examine projects"
task :examine do
  projects = ProjectLoader.load_all

  header = %i[
    name
    ruby_version
    rails_version
    framework_defaults
    kinetic_version
    watt_version
    node_version
    datadog_gem
  ]

  output = projects.map do |project|
    default_results = {name: project.name}

    merged_results = project.exams.each_with_object(default_results) do |exam, memo|
      memo.merge!(exam.results)
    end

    project_results = merged_results.slice(*header).values
    project_results.to_csv
  end

  output.unshift(header.to_csv)

  puts output
end

RSpec::Core::RakeTask.new(:spec)
task default: %i[standard spec]

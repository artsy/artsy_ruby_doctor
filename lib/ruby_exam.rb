class RubyExam
  # also look for kinetic and call out which version it is on!
  # def self.from_repo(project_name)
  #   ruby_version = `cat projects/#{project_name}/.tool-versions | ag ruby`.strip.split(" ").last
  #   rails_version = `cat projects/#{project_name}/Gemfile | ag "gem .rails.,"`.split(" ").last&.gsub(/["']/, "")
  #   datadog_gem = `cat projects/#{project_name}/Gemfile | ag "gem .(ddtrace|datadog)."`.split(" ")[1]&.gsub(/["']/, "")
  #   sentry_gem = `cat projects/#{project_name}/Gemfile | ag "gem .sentry."`.split(" ")[1]&.gsub(/["']/, "")
  #   framework_defaults = `cat projects/#{project_name}/config/application.rb | ag "load_defaults"`.split(" ").last
  #   node_version = `cat projects/#{project_name}/.tool-versions | ag nodejs`.strip.split(" ").last
  #   RubyExam.new(project_name, ruby_version, rails_version, framework_defaults, node_version, datadog_gem, sentry_gem)
  # end

  def initialize(project)
    @project = project
  end

  def results
    {
      ruby_version: ruby_version
    }
  end

  private

  def ruby_version
    ruby_version_data = @project.files[".ruby-version"]&.strip
    return ruby_version_data if ruby_version_data

    tool_versions_data = @project.files[".tool-versions"] || ""
    captures = tool_versions_data.match(/ruby (.*)$/)&.captures || []
    captures.first
  end
end

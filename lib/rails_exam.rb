class RailsExam
  def initialize(project)
    @project = project
  end

  def results
    {
      framework_defaults: framework_defaults,
      rails_version: rails_version
    }
  end

  private

  def framework_defaults
    config_application_data = @project.files["config/application.rb"]
    return unless config_application_data

    captures = config_application_data.match(/load_defaults (.*)$/)&.captures || []
    captures.first
  end

  def rails_version
    gemfile_data = @project.files["Gemfile"]
    return unless gemfile_data

    captures = gemfile_data.match(/^gem .rails., .(.*)./)&.captures || []
    captures.first
  end
end

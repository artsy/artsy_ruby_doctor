class RailsExam
  def initialize(project)
    @project = project
  end

  def results
    {
      framework_defaults: framework_defaults,
      kinetic_version: kinetic_version,
      rails_version: rails_version,
      watt_version: watt_version
    }
  end

  private

  def framework_defaults
    config_application_data = @project.files["config/application.rb"]
    return unless config_application_data

    captures = config_application_data.match(/load_defaults (.*)$/)&.captures || []
    captures.first&.delete('"')
  end

  def kinetic_version
    gemfile_lock_data = @project.files["Gemfile.lock"]
    return unless gemfile_lock_data

    captures = gemfile_lock_data.match(/remote:.*kinetic.*\n.*revision: (.*)/)&.captures || []
    captures.first&.slice(0, 7)
  end

  def rails_version
    gemfile_data = @project.files["Gemfile"]
    return unless gemfile_data

    captures = gemfile_data.match(/^gem .rails., .(.*)./)&.captures || []
    captures.first
  end

  def watt_version
    gemfile_lock_data = @project.files["Gemfile.lock"]
    return unless gemfile_lock_data

    captures = gemfile_lock_data.match(/remote:.*watt.*\n.*revision: (.*)/)&.captures || []
    captures.first&.slice(0, 7)
  end
end

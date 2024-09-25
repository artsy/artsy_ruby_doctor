class RailsExam
  def initialize(project)
    @project = project
  end

  def results
    {
      rails_version: rails_version
    }
  end

  private

  def rails_version
    gemfile_data = @project.files["Gemfile"]
    return unless gemfile_data

    captures = gemfile_data.match(/^gem .rails., .(.*)./)&.captures || []
    captures.first
  end
end

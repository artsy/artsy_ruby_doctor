class RubyExam
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

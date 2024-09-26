class NodeExam
  def initialize(project)
    @project = project
  end

  def results
    {
      node_version: node_version
    }
  end

  private

  def node_version
    tool_versions_data = @project.files[".tool-versions"] || ""
    captures = tool_versions_data.match(/nodejs (.*)$/)&.captures || []
    captures.first
  end
end

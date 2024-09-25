class RubyProject
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def clone
    return unless @name

    clone_command = "git clone git@github.com:artsy/#{@name}.git projects/#{@name} --quiet --depth 1"
    Kernel.system(clone_command, exception: true)
  end

  def files
    {
      ".ruby-version" => ruby_version,
      ".tool-versions" => tool_versions
    }
  end

  private

  def ruby_version
    File.read("projects/#{@name}/.ruby-version")
  rescue
    nil
  end

  def tool_versions
    File.read("projects/#{@name}/.tool-versions")
  rescue
    nil
  end
end

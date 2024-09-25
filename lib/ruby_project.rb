class RubyProject
  attr_reader :name

  def initialize(options)
    @exam_klasses = options[:exam_klasses]
    @name = options[:name]
  end

  def clone
    return unless @name

    clone_command = "git clone git@github.com:artsy/#{@name}.git projects/#{@name} --quiet --depth 1"
    Kernel.system(clone_command, exception: true)
  end

  def exams
    @exam_klasses.map do |klass|
      Object.const_get(klass).new(self)
    end
  end

  def files
    {
      ".ruby-version" => ruby_version,
      ".tool-versions" => tool_versions,
      "Gemfile" => gemfile
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

  def gemfile
    File.read("projects/#{@name}/Gemfile")
  rescue
    nil
  end
end

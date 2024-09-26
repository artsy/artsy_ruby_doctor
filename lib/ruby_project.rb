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
      ".ruby-version" => read_file(".ruby-version"),
      ".tool-versions" => read_file(".tool-versions"),
      "Gemfile" => read_file("Gemfile")
    }
  end

  private

  def read_file(file_path)
    File.read("projects/#{@name}/#{file_path}")
  rescue
    nil
  end
end

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
end

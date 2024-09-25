class RubyProject
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def clone
    system "git clone git@github.com:artsy/#{@name}.git projects/#{@name} --quiet --depth 1"
  end
end

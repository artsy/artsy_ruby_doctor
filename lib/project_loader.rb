class ProjectLoader
  def self.load_all(project_names)
    system "rm -rf projects"
    system "mkdir projects"

    project_names.each do |project_name|
      system "git clone git@github.com:artsy/#{project_name}.git projects/#{project_name} --quiet --depth 1"
      print "."
    end

    print "\n"
    puts "loading complete!"
  end
end

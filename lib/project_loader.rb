class ProjectLoader
  def self.clone_all
    system "rm -rf projects"
    system "mkdir projects"

    projects = ProjectLoader.load_all

    projects.each do |project|
      project.clone
      print "."
    end

    print "\n"
    puts "cloning complete!"

    projects
  end

  def self.load_all
    data = File.read("data/projects.json")
    json = JSON.parse(data)
    project_names = json["projects"].map { |project| project["name"] }
    project_names.map { |project_name| RubyProject.new(project_name) }
  end
end

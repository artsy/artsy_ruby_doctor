describe RubyProject do
  describe "#files" do
    context "when files are missing" do
      it "returns nil for all the files" do
        ruby_project = RubyProject.new("valid")
        expect(File).to receive(:read).exactly(3).times.and_raise(StandardError)
        expect(ruby_project.files).to eq({
          ".ruby-version" => nil,
          ".tool-versions" => nil,
          "Gemfile" => nil
        })
      end
    end

    context "when files are found" do
      it "returns the contents of those files" do
        ruby_project = RubyProject.new("valid")

        expect(File).to receive(:read).with("projects/valid/.ruby-version").and_return("3.3.5")
        expect(File).to receive(:read).with("projects/valid/.tool-versions").and_return("ruby 3.3.5")
        expect(File).to receive(:read).with("projects/valid/Gemfile").and_return('gem "rails", "7.1"')

        expect(ruby_project.files).to eq({
          ".ruby-version" => "3.3.5",
          ".tool-versions" => "ruby 3.3.5",
          "Gemfile" => 'gem "rails", "7.1"'
        })
      end
    end
  end

  describe "#clone" do
    context "with a nil name" do
      it "does nothing" do
        ruby_project = RubyProject.new(nil)
        expect(Kernel).to_not receive(:system)
        ruby_project.clone
      end
    end

    context "with an invalid name" do
      it "raises an exception" do
        ruby_project = RubyProject.new("invalid")
        expected_command = "git clone git@github.com:artsy/invalid.git projects/invalid --quiet --depth 1"
        expect(Kernel).to receive(:system).with(expected_command, exception: true).and_raise(RuntimeError)

        expect do
          ruby_project.clone
        end.to raise_error(RuntimeError)
      end
    end

    context "with a valid name" do
      it "clones that project" do
        ruby_project = RubyProject.new("valid")
        expected_command = "git clone git@github.com:artsy/valid.git projects/valid --quiet --depth 1"
        expect(Kernel).to receive(:system).with(expected_command, exception: true).and_return(true)
        ruby_project.clone
      end
    end
  end
end

describe RubyProject do
  describe "#files" do
    context "when tool-versions file is missing" do
      it "returns nil for that file" do
        ruby_project = RubyProject.new("valid")
        expect(File).to receive(:read).and_raise(StandardError)
        expect(ruby_project.files).to eq({
          ".tool-versions" => nil
        })
      end
    end

    context "when tool-versions file is found" do
      it "returns that file's contents" do
        ruby_project = RubyProject.new("valid")
        expect(File).to receive(:read).and_return("ruby 3.3.5")
        expect(ruby_project.files).to eq({
          ".tool-versions" => "ruby 3.3.5"
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

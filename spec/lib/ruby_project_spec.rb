describe RubyProject do
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

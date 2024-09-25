describe RubyExam do
  describe "ruby version result" do
    let(:files) { {".tool-versions" => tool_versions_data} }
    let(:project) { double(:project, files: files) }

    context "when tool versions data is nil" do
      let(:tool_versions_data) { nil }

      it "returns nil for ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq nil
      end
    end

    context "when tool versions data is an empty string" do
      let(:tool_versions_data) { "" }

      it "returns nil for ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq nil
      end
    end

    context "with tool versions data that has no ruby" do
      let(:tool_versions_data) { "nodejs 18.1.7" }

      it "returns nil for ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq nil
      end
    end

    context "with tool versions data that has a ruby" do
      let(:tool_versions_data) { "ruby 3.3.5" }

      it "returns that ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq "3.3.5"
      end
    end

    context "with a tool versions file that has a node too" do
      let(:tool_versions_data) { "nodejs 18.1.7\nruby 3.3.5" }

      it "returns that ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq "3.3.5"
      end
    end

    context "with ruby version data" do
      let(:files) { {".ruby-version" => "3.3.5"} }
      let(:project) { double(:project, files: files) }

      it "returns that ruby version" do
        exam = RubyExam.new(project)
        ruby_version = exam.results[:ruby_version]
        expect(ruby_version).to eq "3.3.5"
      end
    end
  end
end

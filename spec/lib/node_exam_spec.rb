describe NodeExam do
  describe "node version result" do
    let(:files) { {".tool-versions" => tool_versions_data} }
    let(:project) { double(:project, files: files) }

    context "when tool versions data is nil" do
      let(:tool_versions_data) { nil }

      it "returns nil for ruby version" do
        exam = NodeExam.new(project)
        node_version = exam.results[:node_version]
        expect(node_version).to eq nil
      end
    end

    context "when tool versions data is an empty string" do
      let(:tool_versions_data) { "" }

      it "returns nil for node version" do
        exam = NodeExam.new(project)
        node_version = exam.results[:node_version]
        expect(node_version).to eq nil
      end
    end

    context "with tool versions data that has no node" do
      let(:tool_versions_data) { "ruby 3.3.5" }

      it "returns nil for ruby version" do
        exam = NodeExam.new(project)
        node_version = exam.results[:node_version]
        expect(node_version).to eq nil
      end
    end

    context "with tool versions data that has a node" do
      let(:tool_versions_data) { "nodejs 18.1.7" }

      it "returns that node version" do
        exam = NodeExam.new(project)
        node_version = exam.results[:node_version]
        expect(node_version).to eq "18.1.7"
      end
    end

    context "with a tool versions file that has a ruby too" do
      let(:tool_versions_data) { "nodejs 18.1.7\nruby 3.3.5" }

      it "returns that ruby version" do
        exam = NodeExam.new(project)
        node_version = exam.results[:node_version]
        expect(node_version).to eq "18.1.7"
      end
    end
  end
end

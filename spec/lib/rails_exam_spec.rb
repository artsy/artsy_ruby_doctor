describe RailsExam do
  describe "rails version result" do
    let(:files) { {"Gemfile" => gemfile_data} }
    let(:project) { double(:project, files: files) }

    context "when Gemfile data is nil" do
      let(:gemfile_data) { nil }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "when Gemfile data is an empty string" do
      let(:gemfile_data) { "" }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "with Gemfile data that has no rails" do
      let(:gemfile_data) { 'gem "gris"' }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "with Gemfile data that has a rails" do
      let(:gemfile_data) { 'gem "rails", "7.1.2"' }

      it "returns that rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq "7.1.2"
      end
    end
  end
end

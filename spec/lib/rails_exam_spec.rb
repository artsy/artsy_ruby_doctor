describe RailsExam do
  describe "framework defaults result" do
    let(:files) { {"config/application.rb" => config_application_data} }
    let(:project) { double(:project, files: files) }

    context "when the config application data is nil" do
      let(:config_application_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data is an emtpy string" do
      let(:config_application_data) { "" }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data has no framework defaults" do
      let(:config_application_data) { 'require "rails/all"' }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data has framework defaults" do
      let(:config_application_data) { "config.load_defaults 7.1" }

      it "returns that framework defaults value" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq "7.1"
      end
    end

    context "when the config application data has framework defaults as a string" do
      let(:config_application_data) { 'config.load_defaults "7.1"' }

      it "returns that framework defaults value" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq "7.1"
      end
    end
  end

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

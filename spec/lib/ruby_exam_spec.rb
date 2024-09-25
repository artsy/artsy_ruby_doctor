describe RubyExam do
  describe "ruby version result" do
    context "with nil tool versions file" do
      it "returns nil for ruby version" do
        files = {
          ".tool-versions" => nil
        }
        project = double(:project, files: files)
        exam = RubyExam.new(project)
        expect(exam.results).to eq({
          ruby_version: nil
        })
      end
    end

    context "with tool versions file without ruby" do
      it "returns nil for ruby version" do
        files = {
          ".tool-versions" => "nodejs 18.1.7"
        }
        project = double(:project, files: files)
        exam = RubyExam.new(project)
        expect(exam.results).to eq({
          ruby_version: nil
        })
      end
    end

    context "with a tool versions file that has a node too" do
      it "returns that ruby version" do
        files = {
          ".tool-versions" => "nodejs 18.1.7\nruby 3.3.5"
        }
        project = double(:project, files: files)
        exam = RubyExam.new(project)
        expect(exam.results).to eq({
          ruby_version: "3.3.5"
        })
      end
    end

    context "with a tool versions file that has a ruby" do
      it "returns that ruby version" do
        files = {
          ".tool-versions" => "ruby 3.3.5"
        }
        project = double(:project, files: files)
        exam = RubyExam.new(project)
        expect(exam.results).to eq({
          ruby_version: "3.3.5"
        })
      end
    end
  end
end

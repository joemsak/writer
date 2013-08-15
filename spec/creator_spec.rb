require "writer/file_creator"

module Writer
  describe FileCreator do
    let(:file)    { stub(:file) }
    let(:creator) { FileCreator.new }

    before :each do
      File.stub(:open)
          .with('filename', 'w')
          .and_yield(file)

      File.stub(:open)
          .with('filename', 'r')
          .and_return(true)
    end

    context "with content" do
      it "writes the content" do
        file.should_receive(:puts).with('hi')
        creator.create!('filename', 'hi')
      end
    end

    context "without content" do
      it "leaves a blank line" do
        creator.stub(:template) { nil }
        file.should_receive(:puts).with(nil)
        creator.create!('filename')
      end

      it "uses a template, if it exists" do
        template = stub(:read => "hello\nworld")
        creator.stub(:template) { template.read }

        file.should_receive(:puts).with("hello\nworld")
        creator.create!('filename')
      end
    end
  end
end
